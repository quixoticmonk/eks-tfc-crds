################################################################################
# Node Termination Queue
################################################################################

output "karpenter_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = module.karpenter.queue_arn
}

output "karpenter_queue_name" {
  description = "The name of the created Amazon SQS queue"
  value       = module.karpenter.queue_name
}

output "karpenter_queue_url" {
  description = "The URL for the created Amazon SQS queue"
  value       = module.karpenter.queue_url
}

################################################################################
# Node Termination Event Rules
################################################################################

output "karpenter_event_rules" {
  description = "Map of the event rules created and their attributes"
  value       = module.karpenter.event_rules
}

################################################################################
# Karpenter controller IAM Role
################################################################################

output "karpenter_iam_role_name" {
  description = "The name of the controller IAM role"
  value       = module.karpenter.iam_role_name
}

output "karpenter_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the controller IAM role"
  value       = module.karpenter.iam_role_arn
}

output "karpenter_iam_role_unique_id" {
  description = "Stable and unique string identifying the controller IAM role"
  value       = module.karpenter.iam_role_unique_id
}





