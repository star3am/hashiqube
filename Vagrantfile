# -*- mode: ruby -*-
# vi: set ft=ruby :

# set default provider to docker
ENV['VAGRANT_DEFAULT_PROVIDER'] = "docker"

# create local domain name e.g user.local.dev
user = ENV["USER"].downcase
fqdn = ENV["fqdn"] || "service.consul"

# Helper method for dynamic port allocation with fallback
def get_available_port(preferred_port, min_port = 10000, max_port = 65535)
  # Check if the preferred port is available
  require 'socket'
  begin
    server = TCPServer.new('127.0.0.1', preferred_port)
    server.close
    return preferred_port
  rescue Errno::EADDRINUSE
    puts "Port #{preferred_port} is already in use. Looking for an available port..."
  end

  # Find an available port in the specified range
  available_port = nil
  (min_port..max_port).each do |port|
    begin
      server = TCPServer.new('127.0.0.1', port)
      server.close
      available_port = port
      break
    rescue Errno::EADDRINUSE
      next
    end
  end

  if available_port
    puts "Using alternative port #{available_port} instead of #{preferred_port}"
    return available_port
  else
    puts "No available ports found in range #{min_port}-#{max_port}. Using preferred port #{preferred_port} anyway."
    return preferred_port
  end
end

# Helper method for adaptive resource allocation
def get_system_resources
  # Default values if detection fails
  resources = {
    memory: 4096,  # 4GB default
    cpus: 2        # 2 CPUs default
  }

  begin
    # Try to detect total system memory
    if RUBY_PLATFORM =~ /darwin/
      # macOS
      mem_info = `sysctl -n hw.memsize`.to_i
      resources[:memory] = (mem_info / 1024 / 1024 / 2).to_i  # 50% of total memory
    elsif RUBY_PLATFORM =~ /linux/
      # Linux
      mem_info = `grep MemTotal /proc/meminfo`.match(/\d+/)[0].to_i
      resources[:memory] = (mem_info / 1024 / 2).to_i  # 50% of total memory
    elsif RUBY_PLATFORM =~ /mswin|mingw|cygwin/
      # Windows
      mem_info = `wmic computersystem get totalphysicalmemory`.split("\n")[1].to_i
      resources[:memory] = (mem_info / 1024 / 1024 / 2).to_i  # 50% of total memory
    end

    # Try to detect CPU cores
    if RUBY_PLATFORM =~ /darwin/
      # macOS
      cpu_cores = `sysctl -n hw.ncpu`.to_i
    elsif RUBY_PLATFORM =~ /linux/
      # Linux
      cpu_cores = `nproc`.to_i
    elsif RUBY_PLATFORM =~ /mswin|mingw|cygwin/
      # Windows
      cpu_cores = `wmic cpu get NumberOfCores`.split("\n")[1].to_i
    end

    # Set CPU cores (use 75% of available cores, minimum 2)
    resources[:cpus] = [[(cpu_cores * 0.75).to_i, 1].max, cpu_cores].min if cpu_cores > 0

    # Cap memory at reasonable values
    resources[:memory] = [resources[:memory], 16384].min  # Max 16GB
    resources[:memory] = [resources[:memory], 2048].max   # Min 2GB

    # Cap CPUs at reasonable values
    resources[:cpus] = [resources[:cpus], 8].min  # Max 8 CPUs
    resources[:cpus] = [resources[:cpus], 1].max  # Min 1 CPU

    puts "Detected system resources: #{resources[:memory]}MB RAM, #{resources[:cpus]} CPUs"
    puts "Allocating: #{resources[:memory]}MB RAM, #{resources[:cpus]} CPUs to VM"
  rescue => e
    puts "Error detecting system resources: #{e.message}. Using defaults."
  end

  resources
end

# Define service ports with preferred values
service_ports = {
  'grafana' => 3000,
  'prometheus' => 9090,
  'prometheus-alertmanager' => 9093,
  'vault' => 8200,
  'vault-cluster' => 8201,
  'nomad' => 4646,
  'nomad-server' => 4647,
  'nomad-serf' => 4648,
  'nomad-traefik' => 38080,
  'nomad-traefik-admin' => 38081,
  'waypoint-kubernetes-minikube' => 19702,
  'waypoint-api-kubernetes-minikube' => 19701,
  'waypoint-nomad' => 9702,
  'waypoint-api-nomad' => 9701,
  'boundary' => 9200,
  'consul' => 8500,
  'consul-https' => 8501,
  'consul-grpc' => 8502,
  'consul-server' => 8300,
  'consul-lan' => 8301,
  'consul-wan' => 8302,
  'consul-dns' => 8600,
  'elasticsearch' => 19200,
  'kibana' => 5601,
  'cerebro' => 5602,
  'ansible-www' => 8888,
  'docker-apache2' => 8889,
  'docker-registry-minikube' => 5001,
  'docker-registry-daemon' => 5002,
  'ldap' => 33389,
  'localstack' => 4566,
  'jenkins' => 8088,
  'consul-counter-dashboard' => 9002,
  'consul-counter-api' => 9001,
  'consul-counter-dashboard-test' => 9022,
  'consul-counter-api-test' => 9011,
  'mysql' => 3306,
  'postgres' => 5432,
  'mssql' => 1433,
  'fabio-dashboard' => 9998,
  'fabiolb' => 9999,
  'portainer' => 9333,
  'minikube-dashboard' => 10888,
  'helm-dashboard' => 11888,
  'minikube-traefik' => 18080,
  'minikube-traefik-admin' => 18181,
  'tech-challange-minikube' => 31506,
  'hello-minikube' => 18888,
  'apache-airflow' => 18889,
  'docsify' => 3333,
  'ansible-tower' => 8043,
  'gitlab' => 5580,
  'gitlab-workhorse' => 8181,
  'gitlab-shell' => 32022,
  'vscode-server' => 7777,
  'dbt-docs' => 28080,
  'markdown-quiz-generator' => 8000,
  'uptime-kuma' => 3001,
  'trex' => 6001,
  'argocd' => 18043
}

# Get adaptive resource allocation based on host system
system_resources = get_system_resources()

# https://www.virtualbox.org/manual/ch08.html
vbox_config = [
  { '--memory' => system_resources[:memory].to_s },
  { '--cpus' => system_resources[:cpus].to_s },
  { '--cpuexecutioncap' => '100' },
  { '--biosapic' => 'x2apic' },
  { '--ioapic' => 'on' },
  { '--largepages' => 'on' },
  { '--natdnshostresolver1' => 'on' },
  { '--natdnsproxy1' => 'on' },
  { '--nictype1' => 'virtio' },
  { '--audio' => 'none' },
  { '--uartmode1' => 'disconnected' },
]

# machine(s) hash
machines = [
  {
    :name => "hashiqube0",
    :ip => '10.9.99.10',
    :ssh_port => '2255',
    :disksize => '10GB',
    :vbox_config => vbox_config,
    :synced_folders => [
      { :vm_path => '/osdata', :ext_rel_path => '../../', :vm_owner => 'vagrant' },
      { :vm_path => '/var/jenkins_home', :ext_rel_path => './jenkins/jenkins_home', :vm_owner => 'vagrant' },
    ],
  }
]

Vagrant::configure("2") do |config|

  # check for vagrant version
  Vagrant.require_version ">= 1.9.7"

  if Vagrant::Util::Platform.windows?
    COMMAND_SEPARATOR = "&"
  else
    COMMAND_SEPARATOR = ";"
  end

  # deprecated
  # if @chipset != "Apple"; then
  #   # auto install plugins, will prompt for admin password on 1st vagrant up
  #   required_plugins = %w( vagrant-disksize vagrant-hostsupdater )
  #   required_plugins.each do |plugin|
  #     exec "vagrant plugin install #{plugin}#{COMMAND_SEPARATOR}vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
  #   end
  # end

  machines.each_with_index do |machine, index|

    config.vm.box = "generic/ubuntu2404"
    config.vm.define machine[:name] do |config|

      # config.disksize.size = machine[:disksize] # deprecated
      config.ssh.forward_agent = true
      config.ssh.insert_key = true
      config.ssh.host = "127.0.0.1" # docker on windows tries to ssh to 0.0.0.0
      config.vm.network "private_network", ip: "#{machine[:ip]}"
      config.vm.network "forwarded_port", guest: 22, host: machine[:ssh_port], id: 'ssh', auto_correct: true

      if machines.size == 1 # only expose these ports if 1 machine, else conflicts
        # Use dynamic port allocation with fallback for all services
        puts "Setting up port forwarding with dynamic allocation and fallback..."

        # Special case for consul-dns with UDP protocol
        consul_dns_port = get_available_port(service_ports['consul-dns'])
        config.vm.network "forwarded_port", guest: service_ports['consul-dns'], host: consul_dns_port, protocol: 'udp', id: 'consul-dns'

        # Handle all other services
        service_ports.each do |service_name, guest_port|
          # Skip consul-dns as it's handled separately
          next if service_name == 'consul-dns'

          # Get an available port with fallback
          host_port = get_available_port(guest_port)

          # Configure port forwarding with auto_correct in case the port becomes unavailable
          config.vm.network "forwarded_port", guest: guest_port, host: host_port, id: service_name, auto_correct: true

          # Store the actual port used for later reference
          ENV["HASHIQUBE_#{service_name.upcase.gsub('-', '_')}_PORT"] = host_port.to_s
        end

        # Add LDAP which has a different guest/host port mapping
        ldap_port = get_available_port(service_ports['ldap'])
        config.vm.network "forwarded_port", guest: 389, host: ldap_port, id: 'ldap', auto_correct: true
      end

      config.vm.hostname = "#{machine[:name]}"

      unless machine[:vbox_config].nil?
        config.vm.provider :virtualbox do |vb|
          machine[:vbox_config].each do |hash|
            hash.each do |key, value|
              vb.customize ['modifyvm', :id, "#{key}", "#{value}"]
            end
          end
        end
      end

      config.vm.provider "hyperv" do |hv|
        hv.cpus = system_resources[:cpus].to_s
        hv.memory = system_resources[:memory].to_s
        hv.maxmemory = (system_resources[:memory] * 1.2).to_i.to_s  # 20% more than base memory
        hv.enable_enhanced_session_mode = true
      end

      # IMPORTANT:
      # if you are on Apple M chip you need to use docker provider do:
      # vagrant up --provision-with basetools --provider docker
      # I have not been able to get docker provider to run on Windows, also not inside WSL2, remains a work in progress
      # https://developers.redhat.com/blog/2016/09/13/running-systemd-in-a-non-privileged-container
      # https://github.com/containers/podman/issues/3295
      # --tmpfs /tmp : Create a temporary filesystem in /tmp
      # --tmpfs /run : Create another temporary filesystem in /run
      # --tmpfs /run/lock : Apparently having a tmpfs in /run isn’t enough – you ALSO need one in /run/lock
      # -v /sys/fs/cgroup:/sys/fs/cgroup:ro : Mount the CGroup kernel configuration values into the container
      # https://github.com/docker/for-mac/issues/6073
      # Docker Desktop now uses cgroupv2. If you need to run systemd in a container then:
      # * Ensure your version of systemd supports cgroupv2. It must be at least systemd 247. Consider upgrading any centos:7 images to centos:8.
      # * Containers running systemd need the following options: --privileged --cgroupns=host -v /sys/fs/cgroup:/sys/fs/cgroup:rw.
      # https://betterprogramming.pub/managing-virtual-machines-under-vagrant-on-a-mac-m1-aebc650bc12c
      config.vm.provider "docker" do |docker, override|
        override.vm.box        = nil
        docker.build_dir       = "."
        docker.remains_running = true
        docker.has_ssh         = true
        docker.privileged      = true
        # BUG: https://github.com/hashicorp/vagrant/issues/12602
        # moved to create_args
        # docker.volumes         = ['/sys/fs/cgroup:/sys/fs/cgroup:rw']
        # BUG: https://github.com/hashicorp/nomad/issues/19343 dmidecode
        #      https://stackoverflow.com/questions/54068234/cant-run-dmidecode-on-docker-container
        docker.create_args     = ['-v', '/sys/fs/cgroup:/sys/fs/cgroup:rw', '--cap-add=SYS_RAWIO', '--cgroupns=host', '--tmpfs=/tmp:exec,dev', '--tmpfs=/var/lib/docker:mode=0777,dev,size=15g,suid,exec', '--tmpfs=/run', '--tmpfs=/run/lock'] # '--memory=10g', '--memory-swap=14g', '--oom-kill-disable'
        # Uncomment to force arm64 for testing images on Intel
        # docker.create_args = ["--platform=linux/arm64"]
        docker.env             = { "PROVIDER": "docker", "NAME": "hashiqube" }
      end

      config.vm.provider "podman" do |podman, override|
        override.vm.box        = nil
        podman.build_dir       = "."
        podman.remains_running = true
        podman.has_ssh         = true
        podman.privileged      = true
        podman.create_args     = ['-v', '/sys/fs/cgroup:/sys/fs/cgroup:rw', '--cgroupns=host', '--tmpfs=/tmp:exec,dev', '--tmpfs=/var/lib/docker:mode=0777,dev,size=15g,suid,exec', '--tmpfs=/run', '--tmpfs=/run/lock'] # '--memory=10g', '--memory-swap=14g', '--oom-kill-disable'
        podman.env             = { "PROVIDER": "podman", "NAME": "hashiqube" }
      end

      # mount the shared folder inside the VM
      unless machine[:synced_folders].nil?
        machine[:synced_folders].each do |folder|
          config.vm.synced_folder "#{folder[:ext_rel_path]}", "#{folder[:vm_path]}", owner: "#{folder[:vm_owner]}", mount_options: ["dmode=777,fmode=777"]
          # below will mount shared folder via NFS
          # config.vm.synced_folder "#{folder[:ext_rel_path]}", "#{folder[:vm_path]}", nfs: true, nfs_udp: false, mount_options: ['nolock', 'noatime', 'lookupcache=none', 'async'], linux__nfs_options: ['rw','no_subtree_check','all_squash','async']
        end
      end

      # vagrant up --provision-with bootstrap to only run this on vagrant up
      config.vm.provision "bootstrap", preserve_order: true, type: "shell", privileged: true, inline: <<-SHELL
        echo -e '\e[38;5;198m'"BEGIN BOOTSTRAP $(date '+%Y-%m-%d %H:%M:%S')"
        echo -e '\e[38;5;198m'"running vagrant as #{user}"
        echo -e '\e[38;5;198m'"vagrant IP #{machine[:ip]}"
        echo -e '\e[38;5;198m'"vagrant fqdn #{machine[:name]}"
        echo -e '\e[38;5;198m'"vagrant index #{index}"
        cd ~\n
        grep -q "VAGRANT_IP=#{machine[:ip]}" /etc/environment
        if [ $? -eq 1 ]; then
          echo "VAGRANT_IP=#{machine[:ip]}" >> /etc/environment
        else
          sed -i "s/VAGRANT_INDEX=.*/VAGRANT_INDEX=#{index}/g" /etc/environment
        fi
        grep -q "VAGRANT_INDEX=#{index}" /etc/environment
        if [ $? -eq 1 ]; then
          echo "VAGRANT_INDEX=#{index}" >> /etc/environment
        else
          sed -i "s/VAGRANT_INDEX=.*/VAGRANT_INDEX=#{index}/g" /etc/environment
        fi
      SHELL

      # basetools
      # vagrant up --provision-with basetools to only run this on vagrant up
      config.vm.provision "basetools", preserve_order: true, type: "shell", path: "hashiqube/basetools.sh"

      # docker
      # vagrant up --provision-with docker to only run this on vagrant up
      config.vm.provision "docker", preserve_order: true, type: "shell", path: "docker/docker.sh"

      # docsify
      # vagrant up --provision-with docsify to only run this on vagrant up
      config.vm.provision "docsify", type: "shell", preserve_order: false, privileged: false, path: "docsify/docsify.sh"

      # uptime-kuma
      # vagrant up --provision-with uptime-kuma to only run this on vagrant up
      config.vm.provision "uptime-kuma", preserve_order: true, type: "shell", path: "uptime-kuma/uptime-kuma.sh"

      # vault
      # vagrant up --provision-with vault to only run this on vagrant up
      config.vm.provision "vault", type: "shell", preserve_order: false, privileged: true, path: "vault/vault.sh"

      # consul
      # vagrant up --provision-with consul to only run this on vagrant up
      config.vm.provision "consul", type: "shell", preserve_order: false, privileged: true, path: "consul/consul.sh"

      # nomad
      # vagrant up --provision-with nomad to only run this on vagrant up
      config.vm.provision "nomad", type: "shell", preserve_order: false, privileged: true, path: "nomad/nomad.sh"

      # waypoint on kubernetes using minikube
      # vagrant up --provision-with waypoint-kubernetes-minikube to only run this on vagrant up
      config.vm.provision "waypoint-kubernetes-minikube", run: "never", type: "shell", preserve_order: false, privileged: true, path: "waypoint/waypoint.sh", args: "waypoint-kubernetes-minikube"

      # waypoint on nomad
      # vagrant up --provision-with waypoint-nomad to only run this on vagrant up
      config.vm.provision "waypoint-nomad", run: "never", type: "shell", preserve_order: false, privileged: true, path: "waypoint/waypoint.sh", args: "waypoint-nomad"

      # waypoint on nomad
      # vagrant up --provision-with waypoint to only run this on vagrant up
      config.vm.provision "waypoint", type: "shell", preserve_order: false, privileged: true, path: "waypoint/waypoint.sh", args: "waypoint-nomad"

      # boundary
      # vagrant up --provision-with boundary to only run this on vagrant up
      config.vm.provision "boundary", type: "shell", preserve_order: false, privileged: true, path: "boundary/boundary.sh"

      # packer
      # vagrant up --provision-with packer to only run this on vagrant up
      config.vm.provision "packer", type: "shell", preserve_order: false, privileged: true, path: "packer/packer.sh"

      # sentinel
      # vagrant up --provision-with sentinel to only run this on vagrant up
      config.vm.provision "sentinel", type: "shell", preserve_order: false, privileged: true, path: "sentinel/sentinel.sh"

      # terraform
      # vagrant up --provision-with terraform to only run this on vagrant up
      config.vm.provision "terraform", preserve_order: true, type: "shell", privileged: true, path: "terraform/terraform.sh"

      # localstack
      # vagrant up --provision-with localstack to only run this on vagrant up
      config.vm.provision "localstack", run: "never", type: "shell", preserve_order: true, privileged: false, path: "localstack/localstack.sh"

      # minikube
      # vagrant up --provision-with minikube to only run this on vagrant up
      config.vm.provision "minikube", run: "never", type: "shell", preserve_order: false, privileged: false, path: "minikube/minikube.sh"

      # vscode-server
      # vagrant up --provision-with vscode-server to only run this on vagrant up
      config.vm.provision "vscode-server", run: "never", type: "shell", preserve_order: false, privileged: false, path: "visual-studio-code/vscode-server.sh"

      # ldap
      # vagrant up --provision-with ldap to only run this on vagrant up
      config.vm.provision "ldap", run: "never", type: "shell", preserve_order: false, privileged: true, path: "ldap/ldap.sh"

      # mysql
      # vagrant up --provision-with mysql to only run this on vagrant up
      config.vm.provision "mysql", run: "never", type: "shell", preserve_order: false, privileged: false, path: "database/mysql.sh"

      # postgresql
      # vagrant up --provision-with postgresql to only run this on vagrant up
      config.vm.provision "postgresql", run: "never", type: "shell", preserve_order: false, privileged: false, path: "database/postgresql.sh"

      # mssql
      # vagrant up --provision-with mssql to only run this on vagrant up
      config.vm.provision "mssql", run: "never", type: "shell", preserve_order: false, privileged: false, path: "database/mssql.sh"

      # apache2 with ansible
      # vagrant up --provision-with ansible_local to only run this on vagrant up
      if ARGV.include? '--provision-with'
        config.vm.provision "ansible_local" do |ansible|
          ansible.playbook     = "ansible/playbook.yml"
          ansible.verbose      = true
          ansible.install_mode = "pip"
          ansible.version      = "latest"
          ansible.become       = true
          ansible.extra_vars   = {
            www: {
              package: "apache2",
              service: "apache2",
              docroot: "/var/www/html"
            }
          }
        end
      end

      # jenkins
      # vagrant up --provision-with jenkins to only run this on vagrant up
      config.vm.provision "jenkins", run: "never", type: "shell", preserve_order: false, privileged: false, path: "jenkins/jenkins.sh"

      # apache-airflow
      # vagrant up --provision-with apache-airflow to only run this on vagrant up
      config.vm.provision "apache-airflow", run: "never", type: "shell", preserve_order: false, privileged: false, path: "apache-airflow/apache-airflow.sh"

      # ansible-tower
      # vagrant up --provision-with ansible-tower to only run this on vagrant up
      config.vm.provision "ansible-tower", run: "never", type: "shell", preserve_order: false, privileged: false, path: "ansible-tower/ansible-tower.sh"

      # dbt
      # vagrant up --provision-with dbt to only run this on vagrant up
      config.vm.provision "dbt", run: "never", type: "shell", preserve_order: false, privileged: false, path: "dbt/dbt-global.sh"

      # markdown-quiz-generator
      # vagrant up --provision-with markdown-quiz-generator to only run this on vagrant up
      config.vm.provision "markdown-quiz-generator", run: "never", type: "shell", preserve_order: false, privileged: false, path: "markdown-quiz-generator/markdown-quiz-generator.sh"

      # prometheus and grafana
      # vagrant up --provision-with prometheus-grafana to only run this on vagrant up
      config.vm.provision "prometheus-grafana", run: "never", type: "shell", preserve_order: false, privileged: false, path: "prometheus-grafana/prometheus-grafana.sh"

      # elasticsearch and kibana and cerebro
      # vagrant up --provision-with elasticsearch-kibana-cerebro to only run this on vagrant up
      config.vm.provision "elasticsearch-kibana-cerebro", run: "never", type: "shell", preserve_order: false, privileged: false, path: "elasticsearch-kibana-cerebro/elasticsearch-kibana-cerebro.sh"

      # portainer
      # vagrant up --provision-with portainer to only run this on vagrant up
      config.vm.provision "portainer", run: "never", type: "shell", preserve_order: true, privileged: false, path: "portainer/portainer.sh"

      # gitlab
      # vagrant up --provision-with gitlab to only run this on vagrant up
      config.vm.provision "gitlab", run: "never", type: "shell", preserve_order: false, privileged: false, path: "gitlab/gitlab.sh"

      # trex
      # vagrant up --provision-with basetools,docker,trex to only run this on vagrant up
      config.vm.provision "trex", run: "never", type: "shell", preserve_order: false, privileged: true, path: "trex/trex.sh"

      # argocd
      # vagrant up --provision-with basetools,docker,minikube,argocd to only run this on vagrant up
      config.vm.provision "argocd", run: "never", type: "shell", preserve_order: false, privileged: true, path: "argocd/argocd.sh"

      # vagrant up --provision-with welcome to only run this on vagrant up
      config.vm.provision "welcome", preserve_order: true, type: "shell", privileged: true, run: "always", inline: <<-SHELL
        echo -e '\e[38;5;198m'"HashiQube has now been provisioned, and your services should be running."
        echo -e '\e[38;5;198m'"Below are some links for you to get started."

        # Get the actual ports from environment variables
        DOCSIFY_PORT=${HASHIQUBE_DOCSIFY_PORT:-3333}
        UPTIME_KUMA_PORT=${HASHIQUBE_UPTIME_KUMA_PORT:-3001}
        VAULT_PORT=${HASHIQUBE_VAULT_PORT:-8200}
        CONSUL_PORT=${HASHIQUBE_CONSUL_PORT:-8500}
        NOMAD_PORT=${HASHIQUBE_NOMAD_PORT:-4646}

        echo -e '\e[38;5;198m'"Local documentation http://localhost:${DOCSIFY_PORT} Open this first."
        echo -e '\e[38;5;198m'"Hashiqube status http://localhost:${UPTIME_KUMA_PORT} - Please set up your credentials at first login"
        echo -e '\e[38;5;198m'"Online documentation https://hashiqube.com"
        echo -e '\e[38;5;198m'"Vault http://localhost:${VAULT_PORT} - Use the temporary token from the environment variable VAULT_TOKEN"
        echo -e '\e[38;5;198m'"Consul http://localhost:${CONSUL_PORT}"
        echo -e '\e[38;5;198m'"Nomad http://localhost:${NOMAD_PORT}"
        echo -e '\e[33;1;93m'"Like HashiQube? Say thanks with a Star on GitHub: https://github.com/star3am/hashiqube"
      SHELL

    end
  end
end
