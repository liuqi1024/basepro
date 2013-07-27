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

listen "#{Rails.root}/tmp/unicorn.todo.sock"
# listen 8080

worker_processes 5
timeout 30
