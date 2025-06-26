resource "aws_iam_policy" "policies_postechfiap" {
  name = "policies_app_postechfiap"
  path = "/"
  policy = data.aws_iam_policy_document.policies_postechfiap.json
}

resource "aws_iam_role" "postechfiap" {
  name = "postechfiap"
  assume_role_policy = data.aws_iam_policy_document.postechfiap_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "postechfiap" {
  role       = aws_iam_role.postechfiap.name
  policy_arn = aws_iam_policy.policies_postechfiap.arn
}