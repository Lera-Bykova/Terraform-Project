output "autoscaling_group_heating_name" {
    value = aws_autoscaling_group.Autoscaling_group_heating.name
}
output "autoscaling_group_lighting_name" {
    value = aws_autoscaling_group.Autoscaling_group_lighting.name
}
output "autoscaling_group_auth_name" {
    value = aws_autoscaling_group.Autoscaling_group_auth.name
}
output "autoscaling_group_status_name" {
    value = aws_autoscaling_group.Autoscaling_group_status.name
}