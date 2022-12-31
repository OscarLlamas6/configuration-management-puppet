# Configuration Managment | Puppet

- Ejemplo usando Puppet como herramienta para configuration managment.

![Tablero1](https://i.ibb.co/j34KQq1/Puppet-Architecture-scaled.webp)

# Configurando Hosts

- Agregando info de PuppetMaster y Puppet Slave

```bash
# <ip> puppetServer
# <ip> puppetClient
> sudo nano /etc/hosts
```

# Puppet Master

```bash
# Actualizando paquetes
> sudo apt-get update -y

# Descargando Puppet
> wget https://apt.puppetlabs.com/puppet6-release-focal.deb

# Agregando el paquete de Puppet
> sudo dpkg -i puppet6-release-focal.deb

# Actualizando repositorio de paquetes
> sudo apt-get update -y

# Instalando PuppetServer
> sudo apt-get install puppetserver -y

# En el archivo config de puppetserver cambiar el memory size
# JAVA_ARGS="-Xms1g -Xmx1g -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"
> sudo nano /etc/default/puppetserver

# Iniciar y ejecutar servicio de puppetserver
> sudo systemctl start puppetserver
> sudo systemctl enable puppetserver

# Verificar que el servicio se esta en ejecucion
> sudo systemctl status puppetserver

```

# Puppet Agent

```bash
# Actualizando paquetes
> sudo apt-get update -y

# Descargando Puppet
> wget https://apt.puppetlabs.com/puppet6-release-focal.deb

# Agregando el paquete de Puppet
> sudo dpkg -i puppet6-release-focal.deb

# Actualizando repositorio de paquetes
> sudo apt-get update -y

# Instalar Puppet Agent
> sudo apt-get install puppet-agent -y

# Agregar la siguiente configuracion al archivo de config
# [main] 
# certname = puppetclient
> sudo nano /etc/puppetlabs/puppet/puppet.conf

# Iniciar y ejecutar servicio de puppet
> sudo systemctl start puppet
> sudo systemctl enable puppet

# Verificar que el servicio se esta en ejecucion
> sudo systemctl status puppet

```

# Gestionando certificados SSL

- Agregar configuraciones adicionales al /etc/puppetlabs/puppet/puppet.conf

```toml
[server]
...
dns_alt_names=puppetserver,puppet

[main]
...
certname=puppetclient
```

- Comandos para gestionar certificados

```bash
# Generar un nuevo certificado
> sudo puppetserver ca generate --certname NAME[,NAME...]

# Listar certificados
> sudo puppetserver ca list [--all]

# Revocar un certificado
> sudo puppet ca revoke --certname NAME[,NAME...]

# Firmar un certificado
> sudo puppet ca sign --certname NAME[,NAME...]

# Verificar un certificado
> sudo puppet ssl verify [--certname NAME]

# Para comandos...
> sudo puppetserver ca help
```

# Comandos adicionales

```bash

# Verificar sintaxis de manifiestos .pp
> puppet parser validate [<filename>.pp]

# Enviar pull para solicitar catalogo
> puppet agent -t

# Instalar modulo
> puppet module install <module name> --version x.y.z

```