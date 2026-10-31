
#!/bin/bash
# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html

sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start

sudo echo '<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>StackSimplify | APP-1</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{
min-height:100vh;display:flex;align-items:center;justify-content:center;
font-family:Arial,sans-serif;
background:linear-gradient(135deg,#0f172a,#1e3a8a,#312e81);color:white;
}
.container{
text-align:center;padding:60px 40px;
border:1px solid rgba(255,255,255,.2);border-radius:25px;
background:rgba(255,255,255,.08);backdrop-filter:blur(18px);
box-shadow:0 25px 60px rgba(0,0,0,.3);max-width:700px;width:90%;
}
.logo{font-size:16px;letter-spacing:5px;color:#93c5fd;margin-bottom:25px}
h1{font-size:clamp(30px,6vw,52px);margin-bottom:20px}
p{font-size:18px;color:#cbd5e1;line-height:1.8}
.status{
display:inline-block;margin-top:30px;padding:12px 25px;border-radius:30px;
background:rgba(34,197,94,.15);border:1px solid #22c55e;
color:#86efac;font-weight:bold;
}
.footer{margin-top:45px;font-size:12px;color:#94a3b8;letter-spacing:2px}
</style>
</head>
<body>
<div class="container">
<div class="logo">STACKSIMPLIFY CLOUD PLATFORM</div>
<h1>Welcome to StackSimplify</h1>
<p>APP-1 Infrastructure Dashboard</p>
<div class="status">● APPLICATION ONLINE</div>
<div class="footer">POWERED BY AWS EC2 &amp; TERRAFORM</div>
</div>
</body>
</html>' | sudo tee /var/www/html/index.html

sudo mkdir /var/www/html/app2

sudo echo '<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>StackSimplify | Application Dashboard</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:Arial,sans-serif;min-height:100vh;background:#080f20;color:#f8fafc}
.navbar{
display:flex;justify-content:space-between;align-items:center;
padding:25px 8%;background:rgba(15,23,42,.9);border-bottom:1px solid #25334e;
}
.brand{font-size:21px;font-weight:bold;letter-spacing:1px}
.brand span{color:#60a5fa}
.nav-right{color:#94a3b8;font-size:13px}
.hero{
padding:85px 20px 65px;text-align:center;
background:radial-gradient(ellipse at top,#1e40af 0%,#111c38 45%,#080f20 85%);
}
.tag{
display:inline-block;padding:9px 20px;border:1px solid #3b82f6;
border-radius:30px;color:#93c5fd;font-size:12px;letter-spacing:2px;margin-bottom:25px;
}
h1{font-size:clamp(34px,6vw,65px);margin-bottom:20px}
h1 span{color:#60a5fa}
.subtitle{font-size:18px;color:#94a3b8;line-height:1.8}
.dashboard{max-width:1100px;margin:0 auto;padding:30px 25px 80px}
.section-title{font-size:22px;margin-bottom:25px}
.cards{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:22px}
.card{
background:linear-gradient(145deg,#17243d,#111b30);
border:1px solid #293c5d;border-radius:18px;padding:30px 25px;
transition:transform .3s,border-color .3s;
}
.card:hover{transform:translateY(-7px);border-color:#60a5fa}
.icon{font-size:30px;margin-bottom:20px}
.card h3{font-size:17px;margin-bottom:12px}
.card p{font-size:14px;color:#94a3b8;line-height:1.7}
.version{
display:inline-block;margin-top:15px;padding:7px 15px;
background:#1d4ed8;border-radius:20px;font-size:12px;font-weight:bold;
}
.status{color:#4ade80;font-weight:bold}
.info{
margin-top:35px;padding:30px;border:1px solid #293c5d;
border-radius:18px;background:#111b30;
}
.info h2{font-size:20px;margin-bottom:15px}
.info p{color:#94a3b8;line-height:1.9;font-size:14px}
.footer{
text-align:center;padding:30px;border-top:1px solid #25334e;
color:#64748b;font-size:12px;letter-spacing:1px;
}
@media(max-width:600px){
.navbar{padding:20px 5%;flex-direction:column;gap:12px}
.hero{padding:60px 15px 45px}
.dashboard{padding:25px 15px 50px}
}
</style>
</head>
<body>
<nav class="navbar">
<div class="brand">STACK<span>SIMPLIFY</span></div>
<div class="nav-right">CLOUD APPLICATION PLATFORM</div>
</nav>
<section class="hero">
<div class="tag">TERRAFORM INFRASTRUCTURE DEMO</div>
<h1>Welcome to <span>APP-1</span></h1>
<p class="subtitle">Your application is running successfully.<br>
Infrastructure powered by AWS and automated with Terraform.</p>
</section>
<main class="dashboard">
<h2 class="section-title">Application Overview</h2>
<div class="cards">
<div class="card">
<div class="icon">🚀</div>
<h3>Application Status</h3>
<p>Apache Web Server is running and serving application content.</p>
<div class="version status">● ONLINE</div>
</div>
<div class="card">
<div class="icon">☁️</div>
<h3>Cloud Platform</h3>
<p>Application hosted on Amazon Web Services EC2 infrastructure.</p>
<div class="version">AWS EC2</div>
</div>
<div class="card">
<div class="icon">⚙️</div>
<h3>Infrastructure</h3>
<p>Infrastructure provisioning and configuration managed through Terraform.</p>
<div class="version">TERRAFORM</div>
</div>
<div class="card">
<div class="icon">📦</div>
<h3>Application Version</h3>
<p>Currently deployed application release.</p>
<div class="version">VERSION V1</div>
</div>
</div>
<div class="info">
<h2>About This Application</h2>
<p>Welcome to the StackSimplify application demonstration environment.
This dashboard represents APP-1, deployed on AWS EC2 using Infrastructure
as Code. The application demonstrates cloud infrastructure provisioning,
web server deployment, and application delivery using Terraform.</p>
</div>
</main>
<footer class="footer">
STACKSIMPLIFY CLOUD DEMO | AWS EC2 | TERRAFORM
</footer>
</body>
</html>' | sudo tee /var/www/html/app2/index.html

#sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app2/metadata.html

TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`

sudo curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app2/metadata.html

# AWS Documentation to retrieve EC2 Instance Data
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html
