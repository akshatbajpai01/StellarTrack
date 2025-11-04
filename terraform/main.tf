resource "null_resource" "deploy_stellartrack" {
  triggers = {
    always_run = timestamp()  # Force run on every apply
  }

  # ✅ Linux-compatible deploy provisioner
  provisioner "local-exec" {
    command = "bash ./deploy.sh"
  }

  # ✅ Optional rollback provisioner (Linux)
  provisioner "local-exec" {
    when    = destroy
    command = "bash ${path.module}/rollback.sh"
  }
}
