## dcape-app-template Makefile
## This file extends Makefile.app from dcape
#:

SHELL               = /bin/bash
CFG                ?= .env
CFG_BAK            ?= $(CFG).bak

#- App name
APP_NAME           ?= n8n

#- Docker image name
IMAGE              ?= docker.n8n.io/n8nio/n8n

#- Docker image tag
IMAGE_VER          ?= 1.107.3

# If you need database, uncomment this var
USE_DB             =  yes

#- Encryption key for n8n
ENCRYPTION_KEY     ?= $(shell openssl rand -hex 16; echo)

#- URL for webhook link generation
WEBHOOK_URL        =  https://$(APP_NAME).$(DCAPE_DOMAIN)

#- Default timezone
GENERIC_TIMEZONE  ?= Europe/Moscow

# ------------------------------------------------------------------------------

# if exists - load old values
-include $(CFG_BAK)
export

-include $(CFG)
export

# This content will be added to .env
define CONFIG_CUSTOM

DB_CONTAINER=$(DB_CONTAINER)

endef

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

.default-deploy: prep

prep:
	@echo "Just to show we able to attach"
