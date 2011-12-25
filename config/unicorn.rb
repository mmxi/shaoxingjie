rails_env = ENV["RAILS_ENV"] || "production"
worker_processes 2
working_directory "/var/www/shaoxingjie/"
pid "/var/www/shaoxingjie/tmp/pids/unicorn.pid"

timeout 30

preload_app true

# Listen on a Unix data socket
listen '/var/www/shaoxingjie/tmp/sockets/unicorn.sock', :backlog => 1024

if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

before_fork do |server, worker|
  old_pid = "/var/www/shaoxingjie/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Send 'QUIT' signal to unicorn error!"
    end
  end
end

# Set the path of the log files inside the log folder of the testapp
stderr_path "/var/www/shaoxingjie/log/unicorn.stderr.log"
stdout_path "/var/www/shaoxingjie/log/unicorn.stdout.log"
