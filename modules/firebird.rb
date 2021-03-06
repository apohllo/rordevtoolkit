installation_unit "firebird", :description => "Firebird server and Ruby&Rails adapters" do |i|
  i.execute_unit "firebird-server"
  i.execute_unit "fireruby"
  i.execute_unit "fb_adapter"
  i.install_system_package "flamerobin"
end

installation_unit "firebird-server", :type => :module do |i|
  i.install_system_package "firebird"
  i.step "Configure Firebird", :supported => :ubuntu do |s,i|
    s.surun "dpkg-reconfigure firebird2.1-super"
  end
  i.step "Show access information", :supported => :fedora do |s,i|
    s.info "Access information to your server"
    s.info "  host:     localhsot"
    s.info "  port:     3050"
    s.info "  username: SYSDBA"
    s.info "  password: masterkey"
  end
end

installation_unit "fireruby", 
:description => "Fireruby - Firebird adapter for Ruby" do |i|
  i.step "Download sources" do |s,i|
    s.run "cd /tmp; git clone git://github.com/rowland/fb.git"
  end
  i.step "Build Fireruby" do |s,i|
    s.run "cd /tmp/fb; gem build fb.gemspec"
  end
 
  i.install_gem '/tmp/fb/fb*.gem'
  
  i.step "Remove sources" do |s,i|
    s.run "rm -fr /tmp/fb"
  end
end


installation_unit "fb_adapter", 
:description => "fb_adapter - Firebird adapter for Rails" do |i|
  i.step "Download sources" do |s,i|
    s.run "cd /tmp; git clone git://github.com/rowland/fb_adapter.git"
  end
  i.step "Build fb_adapter" do |s,i|
    s.run "cd /tmp/fb_adapter; rake gem"
  end

  i.install_gem '/tmp/fb_adapter/pkg/fb*.gem'

  i.step "Remove sources" do |s,i|
    s.run "rm -fr /tmp/fb_adapter"
  end
end


