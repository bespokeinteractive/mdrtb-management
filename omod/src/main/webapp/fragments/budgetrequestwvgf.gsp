<%

	ui.includeJavascript("mdrtbdashboard", "moment.js")
%>
<style>
#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
	text-decoration: none;
}
.name {
	color: #f26522;
}

.budget-box{
	border: 1px solid #d3d3d3;
	border-top: 2px solid #363463;
	height: auto;
	margin: 15px 0 0 0;
	padding-bottom: 5px;
}
.budget-box div{
	width: 36%;
	display: inline-block;
}
.budget-box label{
	display: inherit;
	padding: 2px 10px;
	margin: 10px 0 0 0;
	width: 60px;

}
input, form input, select, form select, ul.select, form ul.select, textarea {
	min-width: 0;
	display: inline-block;
	width: 230px;
	height: 38px;
}
input, select, textarea, form ul.select, .form input, .form select, .form textarea, .form ul.select {
	color: #363463;
	padding: 5px 10px;
	background-color: #FFF;
	border: 1px solid #DDD;
}
textarea{
	resize: none;
	height: 120px;
	margin-top: 2px;
	width: 400px;
}
#date-created label{
	display: inline-block;
}
#budgetTable {
	border-top: 2px solid #363463;
	margin-top: 2px;
	font-size: 14px;
}
#budgetTable tr th{
	text-align: center;
}
#budgetTable tr td:nth-child(2),
#budgetTable tr td:nth-child(3),
#budgetTable tr td:nth-child(4),
#budgetTable tr td:nth-child(5){
	text-align: right;
}
.textable{
	padding:0;
}
#totals,
.textable input {
	background-color: transparent;
	margin: 0px;
	border: none;
	width: 100px;
	height: auto;
	text-align: right;
}
#totals {
	font-weight: bold;
}
input.child{
	padding-right: 20px;
}
.button.confirm{
	margin-right:0px;
}
.dialog-content .confirmation{
	margin-bottom: 20px;
}
#modal-overlay {
	background: #000 none repeat scroll 0 0;
	opacity: 0.3 !important;
}
</style>
<script>
	var draftTable;
	var draftTableObject;
	var draftResultsData = [];
	
	
	var getDraftBudget = function(){
		draftTableObject.find('td.dataTables_empty').html('<span><img class="search-spinner" src="'+emr.resourceLink('uicommons', 'images/spinner.gif')+'" /></span>');
		
		var requestData = {
			draft:	true
		}
		
		jq.getJSON('${ ui.actionLink("mdrtbmanagement", "financebudget", "listCurrentBudgets") }', requestData)
			.success(function (data) {
				updateDraftBudgetResults(data);
			}).error(function (xhr, status, err) {
				updateDraftBudgetResults([]);
			}
		);
	};
	
	var updateDraftBudgetResults = function(results){
		draftResultsData = results || [];
		var dataRows = [];
		_.each(draftResultsData, function(result){
			var facility = '<a href="budgetview.page?id=' + result.id + '">' + result.location.name + '</a>';
			  var icons = "<a data-idnt='" + result.id + "' class='approve'>Approve</a>| ";


            dataRows.push([0, result.dated, result.period, facility, result.amount.toString().formatToAccounting(), icons]);
		});

		draftTable.api().clear();
		
		if(dataRows.length > 0) {
			draftTable.fnAddData(dataRows);
		}

		refreshInTable(draftResultsData, draftTable);
	};

    jq(function () {
		draftTableObject = jq("#draftList");
		
		draftTable = draftTableObject.dataTable({
			autoWidth: false,
			bFilter: true,
			bJQueryUI: true,
			bLengthChange: false,
			iDisplayLength: 25,
			sPaginationType: "full_numbers",
			bSort: false,
			sDom: 't<"fg-toolbar ui-toolbar ui-corner-bl ui-corner-br ui-helper-clearfix datatables-info-and-pg"ip>',
			oLanguage: {
				"sInfo": "Budgets",
				"sInfoEmpty": " ",
				"sZeroRecords": "No Budgets Found",
				"sInfoFiltered": "(Showing _TOTAL_ of _MAX_ Budgets)",
				"oPaginate": {
					"sFirst": "First",
					"sPrevious": "Previous",
					"sNext": "Next",
					"sLast": "Last"
				}
			},

			fnDrawCallback : function(oSettings){
				if(isTableEmpty(draftResultsData, draftTable)){
					return;
				}
			},
			
			fnRowCallback : function (nRow, aData, index){
				return nRow;
			}
		});
		
		draftTable.on( 'order.dt search.dt', function () {
			draftTable.api().column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
				cell.innerHTML = i+1;
			} );
		}).api().draw();
		
		jq('#drugName').on('keyup', function () {
			draftTable.api().search( this.value ).draw();
		});
		
		getDraftBudget();
        var confirmDialog = emr.setupConfirmationDialog({
            dialogOpts: {
                overlayClose: false,
                close: true
            },
            selector: '#confirm-dialog',
            actions: {
                confirm: function () {
                    var dataString = jq('form').serialize();

                    jq.ajax({
                        type: "POST",
                        url: '${ui.actionLink("mdrtbmanagement", "financebudget", "addNewBudget")}',
                        data: dataString,
                        dataType: "json",
                        success: function (data) {
                            if (data.status == "success") {
                                jq().toastmessage('showSuccessToast', data.message);
                                window.location.href = "financebudget.page";
                            }
                            else {
                                jq().toastmessage('showErrorToast', 'Post failed. ' + data.message);
                            }
                        },
                        error: function (data) {
                            jq().toastmessage('showErrorToast', "Post failed. " + data.statusText);
                        }
                    });


                    confirmDialog.close();
                },
                cancel: function () {
                    confirmDialog.close();
                }
            }
        });

        jq('table').on('click','.approve', function(){
			jq('.dialog-content .confirmation').html("Confirm approving budget for <b>" + jq('#').text() + " Facility</b> worth <b>&dollar;" + jq('0').val()+"</b> ?");
            confirmDialog.show();
        });
    });
</script>

<div class="dashboard clear">
    <div class="info-section">
        <div class="info-header">
            <i class="icon-filter"></i>
            <h3 class="name">REQUESTS</h3>
			<input id="drugName" type="text" value="" name="drugName" placeholder="Filter Budget" style="width:78%; margin:-40px 5px 0px 10px; padding:0px 15px;">
        </div>
    </div>
</div>

<table id="draftList">
    <thead>
		<th style="width:1px">#</th>
		<th style="width:100px">DATE</th>
		<th style="width:100px">QUARTER</th>
		<th>FACILITY</th>
		<th style="width:100px; text-align: right">AMOUNT</th>
		<th style="width:50px;">ACTIONS</th>
    </thead>

    <tbody>    
    </tbody>
</table>



<div id="confirm-dialog" class="dialog" style="display:none;">
	<div class="dialog-header">
		<i class="icon-folder-open"></i>

		<h3>CONFIRM POSTING</h3>
	</div>

	<div class="dialog-content">
		<div class="confirmation">
			Confirm
		</div>

		<label class="button confirm right">Confirm</label>
		<label class="button cancel">Cancel</label>
	</div>
</div>
