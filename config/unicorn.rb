module Rails
  class <<self
    def root
      File.expand_path("../..", __FILE__)
    end
  end
end

working_directory "#{Rails.root}"
pid "#{Rails.root}/tmp/pids/unicorn.pid"
stderr_path "#{Rails.root}/log/unicorn.log"
stdout_path "#{Rails.root}/log/unicorn.log"

listen "/tmp/unicorn.basepro.sock", :backlog => 64
listen 8080, :tcp_nopush => true

worker_processes 5
timeout 30
