# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.vm.hostname = "openclaw-test"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.name = "openclaw-test"
  end

  # Provision with Ansible
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "tests/test-vm.yml"
    ansible.verbose = "v"
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/python3"
    }
  end
end
