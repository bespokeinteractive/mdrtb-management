<%
    ui.decorateWith("appui", "standardEmrPage", [title: "Finance Dashboard"])
%>


<% if (view == "srs"){ %>
	${ui.includeFragment("mdrtbmanagement", "dashboardsrs")}
<% } else if (view == "wvgf") { %>
	${ui.includeFragment("mdrtbmanagement", "dashboardwvgf")}
<% } else { %>
	404 - Page Not Found
<% } %>
