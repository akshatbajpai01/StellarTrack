resource "null_resource" "deploy_stellartrack" {
  triggers = {
    always_run = timestamp()  # Force run on every apply
  }

  # Linux-compatible deploy
  provisioner "local-exec" {
    command = "bash ./deploy.sh"
  }

  # Linux-compatible rollback
  provisioner "local-exec" {
    when    = destroy
    command = "bash ${path.module}/rollback.sh"
  }
}
