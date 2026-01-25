data "aws_route53_zone" "private_zone" {
  name = var.hosted_zone_name
}

resource "aws_route53_record" "alb_record" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = "week3.${aws_route53_zone.private_zone.name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}


  vpc {
    vpc_id = var.vpc_id
  }

  comment = "Private hosted zone for VPN-based access"
}
