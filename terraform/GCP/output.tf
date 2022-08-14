output "instance_name" {
  value = google_compute_instance.test.*.name
}
output "machine_type" {
  value = [for inst in google_compute_instance.test : inst.machine_type]
}

output "network_ip" {
  value = [for inst in google_compute_instance.test : inst.network_interface.0.network_ip]
}