.PHONY: hl-uninstall
hl-uninstall:
	if [ ! -z "$(KUBE_CONTEXT)" ]; then \
		KUBECONFIG=$(KUBECONFIG) $(HELM) delete --kube-context=$(KUBE_CONTEXT) --purge $(RELEASE) ;\
	else \
		echo No KUBE_CONTEXT configured, skipping helm uninstall... ;\
	fi
