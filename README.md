## README
This image is an sti compatible builder for OpenShift basicauthurl servers:
http://docs.openshift.org/latest/architecture/authentication.html#BasicAuthPasswordIdentityProvider

## Usage
To use this create a git repository containing a file called
`basicauthurl.conf`.  Example contents:

~~~
AUTH_TYPE=ldap
AuthLDAPURL="ldap://example.com:389/dc=example,dc=com?uid?sub?(objectClass=*)"
~~~

This will in turn create a Apache configuration that looks like the following:

~~~
AuthName openshift
AuthType Basic
AuthBasicProvider ldap
AuthLDAPURL ldap://example.com:389/dc=example,dc=com?uid?sub?(objectClass=*)
~~~

It supports all directives listed here:
http://httpd.apache.org/docs/2.4/mod/mod_authnz_ldap.html.  Special handling is
required if the value is intended to have a space.  For example, if the end
result you want is:

~~~
AuthLDAPUrl 'ldap://ldap1.example.com ldap2.example.com/dc=...'
~~~

It would be specified in the configuration file as:

~~~
AuthLDAPUrl="'ldap://ldap1.example.com ldap2.example.com/dc=...'"
~~~

It also supports htpasswd authentication for testing purposes.  You can create
an htpasswd file locally and check it in:

~~~
AUTH_TYPE=htpasswd
HTPASSWD_FILE=openshift-passwd
~~~

## OpenShift Master setup:

* Generate cerificates for the service:

~~~
cd /var/lib/openshift

# By default this will use the OpenShift Master CA
openshift admin create-server-cert --cert='openshift.local.certificates/basicauthurl/cert.crt' --hostnames="basicauthurl.example.com" --key='openshift.local.certificates/basicauthurl/key.key
~~~

* Add the following to the Master's configuration file (Currently
  `/etc/openshift/master.yaml` for the OpenShift Enterprise Beta):

~~~
  identityProviders:
  - challenge: true
    login: true
    name: basicauthurl
    provider:
      apiVersion: v1
      kind: BasicAuthPasswordIdentityProvider
      url: https://basicauthurl.example.com/validate
      ca: /var/lib/openshift/openshift.local.certificates/ca/cert.crt
~~~

*:

## TODO:

* The intention is certainly not to continue with a mod_php script. Right now
  this is primarily a prototype for hosting a basicauthurl server on OpenShift
  itself.
