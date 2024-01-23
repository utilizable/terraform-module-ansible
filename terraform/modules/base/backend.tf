# ./modules/../backend.tf

# MODULE - BACKEND 
# ------------------


terraform {
  # configuration - backend
  required_providers {
    ansible = {
      source  = "ansible/ansible"
    }
  }
}

