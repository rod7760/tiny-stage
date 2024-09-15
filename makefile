

clean:
	podman rm -f freeipa-server-image
ipa:
	podman build -t freeipa-server-image .
	podman run -p 443:443 --hostname ipa.tinystage.test -d --name freeipa-server-container freeipa-server-image || exit 0
	podman exec --workdir /opt/tiny-stage freeipa-server-container /bin/bash -c "ansible-playbook ansible/ipa.yml"

auth:
	podman build -t auth .
	podman run --hostname auth.tinystage.test -d --replace --name auth auth
	podman exec --workdir /opt/tiny-stage auth /bin/bash -c "ansible-playbook ansible/auth.yml"
