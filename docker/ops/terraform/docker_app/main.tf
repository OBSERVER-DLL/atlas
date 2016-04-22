resource "docker_image" "app" {
    name = "${var.docker_image}"
    keep_updated = true
}

resource "docker_container" "app" {
    image = "${docker_image.app.latest}"
    name = "app_${count.index+1}"
    hostname = "app_${count.index+1}"
    count = "${var.count}"
    must_run = true
    command = ["/sbin/my_init"]
    ports = {
        internal = "80"
        external = "80"
    }
    ports = {
        internal = "22"
        external = "${var.port}${count.index}"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo sed -i -- 's/{{ atlas_username }}/${var.atlas_username}/g' /etc/service/consul/run",
            "sudo sed -i -- 's/{{ atlas_token }}/${var.atlas_token}/g' /etc/service/consul/run",
            "sudo sed -i -- 's/{{ atlas_environment }}/${var.atlas_environment}/g' /etc/service/consul/run",
            "sudo sv restart consul"
        ]
        connection {
            user = "${var.user}"
            key_file = "${var.key_file}"
            agent = "${var.agent}"
            host = "${var.host}"
            port = "${var.port}${count.index}"
        }
    }
}
