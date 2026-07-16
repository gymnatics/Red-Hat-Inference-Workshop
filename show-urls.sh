#!/bin/bash
# Print all URLs needed for the workshop
NS="${NAMESPACE:-$(oc project -q 2>/dev/null)}"

if [ -z "$NS" ]; then
    echo "Error: NAMESPACE not set. Run: export NAMESPACE=user-XX"
    exit 1
fi

echo ""
echo "=== Workshop URLs for $NS ==="
echo ""

echo "OpenWebUI (open in browser):"
ROUTE=$(oc get route open-webui -n "$NS" -o jsonpath='{.spec.host}' 2>/dev/null)
if [ -n "$ROUTE" ]; then
    echo "  https://$ROUTE"
else
    echo "  (not deployed yet)"
fi

echo ""
echo "LlamaStack URL (paste in Connections > URL):"
echo "  http://llamastack-workshop-service.$NS.svc.cluster.local:8321/v1"

echo ""
echo "Model Token (paste in Connections > Bearer Auth):"
TOKEN_SECRET=$(oc get secret -n "$NS" -o name 2>/dev/null | grep "token.*qwen3" | head -1)
if [ -n "$TOKEN_SECRET" ]; then
    oc get "$TOKEN_SECRET" -n "$NS" -o jsonpath='{.data.token}' 2>/dev/null | base64 -d 2>/dev/null
    echo ""
else
    echo "  (model not deployed yet)"
fi

echo ""
echo "mcpo Tools URL (paste in Integrations > External Tool Servers > URL):"
echo "  http://mcpo.$NS.svc.cluster.local:8000/kubernetes"
echo "  Type: OpenAPI | Auth: None"
echo ""
