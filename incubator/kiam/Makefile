helm-params=--set server.tlsFiles.ca=$(KIAM_CA_PEM) \
			--set server.tlsFiles.cert=$(KIAM_SERVER_PEM) \
			--set server.tlsFiles.key=$(KIAM_SERVER_KEY) \
			--set agent.tlsFiles.ca=$(KIAM_CA_PEM) \
			--set agent.tlsFiles.cert=$(KIAM_AGENT_PEM) \
			--set agent.tlsFiles.key=$(KIAM_AGENT_KEY)

include ../common-makefiles/default.mk

bootstrap:
	{ \
		set -e ;\
		cd ./scripts ;\
		./generate-certs.sh ;\
		cd .. ;\
		echo ;\
		echo "Certs generated. Use them with '. ./scripts/export-certs.sh && make hl-install'" ;\
	}

install:
	{ \
		set -e ;\
		if [ "$$APPROVED" = "true" ]; then \
			if [ -z "$$KIAM_CA_CRT" ]; then \
				echo ;\
				echo Generating certs... ;\
				make bootstrap ;\
				. ./scripts/export-certs.sh ;\
			else \
				echo ;\
				echo Secrets already exported to the shell ;\
			fi ;\
			make hl-install ;\
		else \
			echo Nothing to do. Return with 'APPROVED=true' to install ;\
		fi \
	}