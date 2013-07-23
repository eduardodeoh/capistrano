#http://spin.atomicobject.com/2013/03/23/capistrano-deploys-ssh-agent/
#http://mhfs.com.br/2013/02/05/setting-ssh-forwardagent-up-for-capistrano-slash-github-deploy.html
set_default(:my_ssh_private_key) { "$HOME/.ssh/id_rsa" }
set_default(:git_repo_provider, "Github")

#exec ssh-agent bash
#eval "$(ssh-agent)"
#ssh-add #{my_ssh_private_key}

namespace :ssh_agent do
  desc "Prepare environment ssh agent forward private key to permit deploy via #{git_repo_provider}"
  task :check do
    pid = ENV["SSH_AGENT_PID"]
    raise %|No ssh-agent active (cannot authenticate to #{git_repo_provider} without it.) Try running "eval `ssh-agent`; ssh-add #{my_ssh_private_key}".| if pid.nil? or pid == "" or pid.to_i == 0

    begin
      Process.getpgid(pid.to_i)
    rescue Errno::ESRCH
      raise %|The ssh-agent at pid #{pid} has died (cannot authenticate to bitbucket without it.) Try running "eval `ssh-agent`; ssh-add #{my_ssh_private_key}".|
    end

    if `ssh-add -L` =~ /no identities/
      raise %|The ssh-agent at pid #{pid} has no keys. Have you run "ssh-add #{my_ssh_private_key}"?|
    end
  end
    before "deploy:update", "ssh_agent:check"
end
