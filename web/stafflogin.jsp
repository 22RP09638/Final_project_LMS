<html>
    <head>
        <title>LIBRARY MANAGEMENT SYSTEM</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            form{
			background: #fff;
			width: 550px;
			height:0px;
		
                        margin-left:-190px;
                        margin-top: -38px;
                        border: 10px;
		}
		h1{
			font-weight: bold;
			width: 420px;
			height: 50px;
                        margin-left: 180px;
                        color: white;
			
		}
		label{
			text-transform: capitalize;
			color: black;
			margin-left: 220px;
                          margin-top: 40px;
                          font-weight: bold;
                           font-size: 20px;
		}
                input{
                   margin-left: 400px;
                  
                        width: 200px;
                        height: 30px;
                        padding: 5px;
                        margin: 5px;
                          margin-top: 30px;
                }
		button{
			background: #294c8e;
			color: black;
			margin-left: 320px;
                        width: 220px;
			height: 50px;
                        font-weight: bold;
		}
                .btns a{
                    color: black
                }
                .btns{
                    display: flex;
                    flex-direction: block;
                    gap:1rem;
                    margin: 0 auto;
                    width: 100vw;
                    padding-iniline:auto;
                    align-items: center;
                    justify-content: center;
                }
                .btn{
                    padding: 0.6rem;
                    border-radius: .2rem;
                }
                .btn-primary{
                    background-color: blue;
                    color: white;
                }
                  .btn-outline-primary{
                    background-color: white;
                    color: black;
                    border: solid 1px;
                }
                .container{
			max-width: 500px;
			margin: auto;
			padding: 1rem;
			border: 1px ;
			border-radius: 8px;
			background: white;
                        margin-top: 100px;
                        height: 400px;
		}
                .header{
                    background: #294c8e;
			width: 532px;
			height: 50px;
			margin-left: 174px;
                        margin-top: -20px;
                }
                h2{
                    margin-left: 200px;
                    font-size: 20px;
                }
                a{
                    font-size: 20px;
                    text-decoration: none;
                    color: red;
                     margin-top: 30px;
                }

            </style>
    </head>
    <body>
                   

       <div class="container">
        <form method="post" action="login">
            <input type="hidden" name="role" value="staff">
         <div class="header">
            <h1>Staff LOGIN</h1>
         </div>
         <label>Email:</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <input type="text" name="email" required="" placeholder="example 21RP00029"><br><br>
          <label>Password</label>&nbsp;&nbsp;
          <input type="password" name="pass" required=""><br><br>
          <button type="submit" name="submit">LOGIN</button><br><br>
            <h2>Forgot Password?Click Here <a href="reset.html">RESET</a></h2>
            
                    </form>
       </div>
        <div class="btns">
            <div class="btn btn-outline-primary">
                <a href="guestSignup.jsp">Create Guest Account</a>
            </div>
              <div class="btn btn-primary">
                <a href="studentLogin.jsp">LOGIN AS STUDENT</a>
              </div>
              <div class="btn btn-outline-primary">
                <a href="login.jsp">LOGIN AS GUEST</a>
              </div>
                <div class="btn btn-outline-primary">
                <a href="superadminlogin.jsp">LOGIN AS SUPER Admin</a>
              </div>
        </div>
        
    </body>
</html>