This image is an sti compatible builder for OpenShift basicauthurl servers:
http://docs.openshift.org/latest/architecture/authentication.html#BasicAuthPasswordIdentityProvider

To use this create a git repository containing a file called
`basicauthurl.conf`.  Example contents:

~~~
AUTH_TYPE=ldap
AuthLDAPURL="ldap://example.com:389/dc=example,dc=com?uid?sub?(objectClass=*)"
~~~

Soon it will support all directives for mod_ldap:
http://httpd.apache.org/docs/2.4/mod/mod_authnz_ldap.html

It also supports htpasswd authentication for testing purposes.  You can create
an htpasswd file locally and check it in:

~~~
AUTH_TYPE=htpasswd
HTPASSWD_FILE=openshift-passwd
~~~

## Implementation Details
Right now this is primarily a prototype for hosting a basicauthurl server on
OpenShift itself.  The intention is certainly not to continue with a mod_php
script.
