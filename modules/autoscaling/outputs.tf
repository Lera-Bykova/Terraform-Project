output "autoscaling_group_heating_name" {
    value = aws_autoscaling_group.Autoscaling_group_public[0].name
}
output "autoscaling_group_lighting_name" {
    value = aws_autoscaling_group.Autoscaling_group_public[1].name
}
output "autoscaling_group_status_name" {
    value = aws_autoscaling_group.Autoscaling_group_public[2].name
}
output "autoscaling_group_auth_name" {
    value = aws_autoscaling_group.Autoscaling_group_private.name
}