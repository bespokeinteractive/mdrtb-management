
<nav id="colorNav">

	<ul>
		<li class="green">

        </class></a><a href="financebudget.page" class="icon-home"></a>
			<ul></ul>
		</li>
		<li class="blue" span class="title">Fund Request</span>
			<a href="cashrequest.page" class="icon-twitter"></a>

		</li>
		<li class="yellow" span class="title">Cash Disbursement</span>
			<a href="cashdisbursement.page" class="icon-beaker"></a>

		</li>
		<li class="purple" span class="title">Ledger</span>
			<a href="ledgers.page" class="icon-envelope"></a>

		</li>
		<li class="purple" span class="title">HRM</span>
			<a href="#" class="icon-envelope"></a>

		</li>
		<li class="purple" span class="title">Reports (List)</span>
			<a href="#" class="icon-envelope"></a>

		</li>
	</ul>
</nav>

<style>

*{
	margin:0;
	padding:0;
}


/*-------------------------
	General Styles
--------------------------*/

#colorNav > ul{
	width: 1110px; /* Increase when adding more menu items */
	margin:0 auto;
}

#colorNav > ul > li{ /* will style only the top level li */
	list-style: none;
	box-shadow: 0 0 10px rgba(100, 100, 100, 0.2) inset,1px 1px 1px #CCC;
	display: inline-block;
	line-height: 1;
	margin: 1px;
	border-radius: 3px;
	position:relative;
}

#colorNav > ul > li > a{
	color:inherit;
	text-decoration:none !important;
	font-size:24px;
	padding: 25px;
}

#colorNav li ul{
	position:absolute;
	list-style:none;
	text-align:center;
	width:180px;
	left:50%;
	margin-left:-90px;
	top:70px;
	font:bold 12px 'Open Sans Condensed', sans-serif;

	/* This is important for the show/hide CSS animation */
	max-height:0px;
	overflow:hidden;

	-webkit-transition:max-height 0.4s linear;
	-moz-transition:max-height 0.4s linear;
	transition:max-height 0.4s linear;
}

#colorNav li ul li{
	background-color:#313131;
}

#colorNav li ul li a{
	padding:12px;
	color:#fff !important;
	text-decoration:none !important;
	display:block;
}

#colorNav li ul li:nth-child(odd){ /* zebra stripes */
	background-color:#363636;
}

#colorNav li ul li:hover{
	background-color:#444;
}

#colorNav li ul li:first-child{
	border-radius:3px 3px 0 0;
	margin-top:25px;
	position:relative;
}

#colorNav li ul li:first-child:before{ /* the pointer tip */
	content:'';
	position:absolute;
	width:1px;
	height:1px;
	border:5px solid transparent;
	border-bottom-color:#313131;
	left:50%;
	top:-10px;
	margin-left:-5px;
}

#colorNav li ul li:last-child{
	border-bottom-left-radius:3px;
	border-bottom-right-radius:3px;
}

/* This will trigger the CSS */
/* transition animation on hover */

#colorNav li:hover ul{
	max-height:200px; /* Increase when adding more dropdown items */
}


/*----------------------------
	Color Themes
-----------------------------*/


#colorNav li.green{
	/* This is the color of the menu item */
	background-color:#00c08b;

	/* This is the color of the icon */
	color:#127a5d;
}

#colorNav li.red{		background-color:#ea5080;color:#aa2a52;}
#colorNav li.blue{		background-color:#53bfe2;color:#2884a2;}
#colorNav li.yellow{	background-color:#f8c54d;color:#ab8426;}
#colorNav li.purple{	background-color:#df6dc2;color:#9f3c85;}






</style>