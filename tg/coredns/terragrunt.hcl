terraform {
  source = "../../tf//cloud_init"

  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "validate",
      "refresh",
      "destroy",
    ]

    # With the get_terragrunt_dir() function, you can use relative paths!
    required_var_files = []
  }
}

include {
  path = find_in_parent_folders()
}

inputs = {

}