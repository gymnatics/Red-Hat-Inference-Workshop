#!/bin/bash
# Print all URLs needed for the workshop
NS="${NAMESPACE:-$(oc project -q 2>/dev/null)}"
echo ""
echo "=== Workshop URLs for $NS ==="
echo ""
echo "OpenWebUI:"
echo "  https://$(oc get route open-webui -n $NS -o jsonpath='{.spec.host}' 2>/dev/null)"
echo ""
echo "LlamaStack (paste in OpenWebUI Connections > URL):"
echo "  http://llamastack-workshop-service.$NS.svc.cluster.local:8321/v1"
echo ""
echo "Model Token (paste in OpenWebUI Connections > Bearer):"
oc get secret -n $NS -o name 2>/dev/null | grep "token.*qwen3" | head -1 | xargs -I{} oc get {} -n $NS -o jsonpath='{.data.token}' 2>/dev/null | base64 -d 2>/dev/null
echo ""
echo ""
echo "mcpo Tools (paste in OpenWebUI Integrations > External Tool Servers > URL):"
echo "  http://mcpo.$NS.svc.cluster.local:8000/kubernetes"
echo ""
