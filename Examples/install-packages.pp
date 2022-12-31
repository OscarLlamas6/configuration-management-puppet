class packages {

  $enhancers = [ 'python', 'golang', 'nodejs' ]
  package { $enhancers: ensure => 'installed' }

}


node 'puppetclient' {
  include packages
}
