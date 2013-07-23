namespace :ssh do
  desc "Setup long timeouts for ssh connection"
  task :install, roles: :app do
    sshd = <<-BASHRC
  ClientAliveInterval 60
  ClientAliveCountMax 1200
    BASHRC
    cmd = %Q{grep -R "ClientAliveInterval" /etc/ssh/sshd_config}
    content = capture( %Q{bash -c '#{cmd}' || echo "false"}).strip
    if content == 'false'
      put sshd, '/tmp/sshd'
      run 'cat /etc/ssh/sshd_config /tmp/sshd > /tmp/sshd.tmp'
      run 'rm /tmp/sshd'
      run "#{sudo} mv /tmp/sshd.tmp /etc/ssh/sshd_config"
    else
      run 'echo "FILE /etc/ssh/sshd_config" IS ALREADY UPDATED!'
    end
  end
  after "deploy:install", "ssh:install"
end