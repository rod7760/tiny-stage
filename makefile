

clean:
	podman rm -f ipa
ipa:
	podman build -t ipa .
	podman run --hostname ipa.tinystage.test -d --name ipa ipa || exit 0
	podman exec --workdir /opt/tiny-stage ipa /bin/bash -c "ansible-playbook ansible/ipa.yml"

auth:
	podman build -t auth .
	podman run --hostname auth.tinystage.test -d --replace --name auth auth
	podman exec --workdir /opt/tiny-stage auth /bin/bash -c "ansible-playbook ansible/auth.yml"
