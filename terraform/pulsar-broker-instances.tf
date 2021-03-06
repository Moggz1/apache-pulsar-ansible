resource "oci_core_instance" "pulsar-broker" {
    count = "${var.pulsar_broker_instance_count}"
    availability_domain = "${var.instance_availability_domain}"
    compartment_id = "${var.compartment_ocid}"
    shape = "${var.instance_shape}"

    agent_config {
        is_monitoring_disabled = false
    }
    create_vnic_details {
        subnet_id = "${var.subnet_ocid}"
        assign_public_ip = "${var.use_public_ip}"
    }
    metadata = {
        ssh_authorized_keys = "${var.ssh_public_key}"
    }
    display_name = "pulsar-broker-${count.index + 1}"
    source_details {
        source_id = "${var.instance_image_ocid}"
        source_type = "image"
    }
    preserve_boot_volume = false
}

output "pulsar-broker-instance-public-ip-details" {
  value = "${oci_core_instance.pulsar-broker[*].public_ip}"
}