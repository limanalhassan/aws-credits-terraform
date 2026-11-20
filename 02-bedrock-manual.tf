# Activity: Use a foundation model in the Amazon Bedrock playground (US$20)
# --------------------------------------------------------------------------
# This one is NOT creatable with Terraform. The activity's completion is
# detected from the Bedrock Playground UI session, not from a CloudTrail
# event, so the only way to earn this $20 is manually.
#
# Do these three steps in the console, which takes about one minute:
#
#   1. Open Bedrock model access:
#        https://console.aws.amazon.com/bedrock/home?region=us-east-1#/modelaccess
#      Click "Enable specific models" and grant yourself access to any
#      Amazon Nova model (Nova Lite is fastest to approve).
#
#   2. Open the Bedrock Playground:
#        https://console.aws.amazon.com/bedrock/home?region=us-east-1#/playground
#      Pick "Chat / Text", select Amazon Nova Lite, type any prompt, Run.
#
#   3. Wait a few minutes. The activity flips to "Completed" and $20 lands.
#
# If you later want to call Bedrock from the CLI (not needed for this
# activity, but useful to know), the one-liner is:
#
#   aws bedrock-runtime invoke-model \
#     --model-id amazon.nova-lite-v1:0 \
#     --content-type application/json \
#     --accept application/json \
#     --body '{"messages":[{"role":"user","content":[{"text":"hello"}]}]}' \
#     /tmp/out.json && cat /tmp/out.json
