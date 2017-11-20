<%
    ui.decorateWith("appui", "standardEmrPage", [title: "Finance Dashboard"])
%>

<style>
	#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
		text-decoration: none;
	}
	.name {
		color: #f26522;
	}
</style>


<% if (view == "srs"){ %>
	${ui.includeFragment("mdrtbmanagement", "dashboardsrs")}
<% } else if (view == "wvgf") { %>
	${ui.includeFragment("mdrtbmanagement", "dashboardwvgf")}
<% } else { %>
	404 - Page Not Found
<% } %>
