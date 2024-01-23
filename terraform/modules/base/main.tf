# ./modules/../main.tf

# MODULE - RESOURCES 
# ------------------

# install ansible modules 
resource "null_resource" "requirements" {
	provisioner "local-exec" {
		command = <<-EOT
      if [ -f /ansible/requirements.yml ]; then
		  	until command ansible-galaxy install -r /ansible/requirements.yml; do
		  		sleep 5
		  	done
      fi;
		EOT
	}
}

# install ansible modules 
#resource "null_resource" "requirements" {
#	depends_on = [ null_resource.requirements ]
#	provisioner "local-exec" {
#		command = <<-EOT
#      ansible-playbook           \
#        ./playbooks/playbook/yml \
#        --inventory              \
#        ./inventories/hosts       
#		EOT
#	}
#}

# execute ansible playbook
resource "ansible_playbook" "playbook-ansible" {

	depends_on = [ null_resource.requirements ]

  # ------------------
  # required 

  # Name of the desired host,
  name = "anykey.pl"

  # Path to ansible playbook. 
  playbook = "/ansible/playbooks/playbook.yml"

  # ------------------
  # optional 

  extra_vars = {
    # ansible core
    ansible_user = "root"
    ansible_port = "8005"
    # playbook extras 
    vm_id = "111"

		ansible_check_mode = true  # <- here
  }

  # ------------------
  # logs

  # disable / enable ansible logs
  # -
  ignore_playbook_failure = true 

  # verbosity level between 0 and 6
  # The higher the 'verbosity', the more debug details will be printed.
  # -
  verbosity = 6
}

output "playbook_stderr" {
  value = ansible_playbook.playbook-ansible.ansible_playbook_stderr
}

output "playbook_stdout" {
    value = ansible_playbook.playbook-ansible.ansible_playbook_stdout
}
