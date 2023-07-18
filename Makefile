# dcape-app-whoami Makefile

SHELL               = /bin/bash
CFG                ?= .env

#- App name
APP_NAME           ?= service-template

#- Docker image name
IMAGE              ?= ghcr.io/lekovr/service-template

#- Docker image tag
IMAGE_VER          ?= 0.1.0

# Just for example

#USE_DB = yes

# ------------------------------------------------------------------------------

-include $(CFG)
export

# define CONFIG_CUSTOM
# # ------------------------------------------------------------------------------
# # Sample config for .env
# #SOME_VAR=value
#
# endef

# ------------------------------------------------------------------------------
# Find and include DCAPE_ROOT/Makefile
DCAPE_COMPOSE   ?= dcape-compose
DCAPE_ROOT      ?= $(shell docker inspect -f "{{.Config.Labels.dcape_root}}" $(DCAPE_COMPOSE))

ifeq ($(shell test -e $(DCAPE_ROOT)/Makefile.app && echo -n yes),yes)
  include $(DCAPE_ROOT)/Makefile.app
else
  include /opt/dcape/Makefile.app
endif

# ------------------------------------------------------------------------------

## Template support code, used once
use-template:

