FROM quay.io/fedora/fedora:latest

# TODO don't install weakdeps
RUN dnf install -y --nodocs \
	ansible \
	hostname \
	systemd
# Python link unsure if python-is-python3 exists or something
RUN ln -s /usr/bin/python3 /usr/bin/python

# Prepare for basic ipa-server-install in container
# Address failing nis-domainname.service in the ipa-client-install step
RUN mv /usr/bin/nisdomainname /usr/bin/nisdomainname.orig
ADD hostnamectl-wrapper /usr/bin/nisdomainname
RUN chmod 777 /usr/bin/nisdomainname # TODO change perms

COPY ./ /opt/tiny-stage
CMD ["/usr/sbin/init"]
