
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="it">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no'
	name='viewport' />

<!-- Title -->
<title>WLB - Prenotazione postazione</title>

<!-- Icon -->
<link rel="apple-touch-icon" sizes="57x57"
	href="img/favicon/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60"
	href="img/favicon/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72"
	href="img/favicon/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76"
	href="img/favicon/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114"
	href="img/favicon/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120"
	href="img/favicon/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144"
	href="img/favicon/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152"
	href="img/favicon/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180"
	href="img/favicon/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"
	href="img/favicon/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="img/favicon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="img/favicon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="img/favicon/favicon-16x16.png">
<link rel="manifest" href="img/favicon/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage"
	content="img/favicon/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">

<!-- CSS Files -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/atlantis.css">

<!-- Fonts and icons -->
<script src="js/plugin/webfont/webfont.min.js"></script>
<script>
	WebFont.load({
		google : {
			"families" : [ "Lato:300,400,700,900" ]
		},
		custom : {
			"families" : [ "Flaticon", "Font Awesome 5 Solid",
					"Font Awesome 5 Regular", "Font Awesome 5 Brands",
					"simple-line-icons" ],
			urls : [ 'css/fonts.min.css' ]
		},
		active : function() {
			sessionStorage.fonts = true;
		}
	});
</script>

<style>
.flex-container {
	display: flex;
	flex-wrap: wrap;
}

.flex-container>svg {
	margin: 10px;
	margin-right: 0px;
}
</style>

</head>

<body>
	<div class="wrapper">
		<jsp:include page="Header.jsp" />

		<div class="main-panel">

			<!-- BODY PAGE-->
			<div class="content" style="display: flex; align-items: center;">
				<div class="container mt-4 text-center">

					<div class="col-lg-9 mx-auto">

						<div class="card">


							<div class="card-header">
								<h3 class="my-auto">Seleziona il giorno e la postazione da
									prenotare:</h3>
								<div class="row" id="selectRow">
									<div class="col-sm-4">
										<div class="form-group">
											<label for="dateSelect">Data:</label> <select
												class="form-control custom-select form-control-sm"
												id="dateSelect">
												<c:forEach items="${availableDates}" var="data">
													<option>${data}</option>
												</c:forEach>
											</select>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<label for="floorSelect">Piano:</label> <select
												class="form-control custom-select form-control-sm"
												id="floorSelect">

											</select>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<label for="roomSelect">Stanza:</label> <select
												class="form-control custom-select form-control-sm"
												id="roomSelect">
											</select>
										</div>
									</div>
								</div>
							</div>

							<div class="card-body">
								<div style="overflow-y: scroll; height: 230px;" id="scrollDiv">
									<div class="flex-container"></div>
									<form action="WorkstationPrenotationServlet" id="finalForm"></form>
								</div>
							</div>


							<!-- END CARD -->
						</div>

						<!-- END CARD -->
					</div>

					<!-- END CONTAINER -->
				</div>

				<!-- END CONTENT -->
			</div>

			<jsp:include page="Footer.jsp" />

			<!-- END MAIN-PANEL -->
		</div>

		<!-- END WRAPPER -->
	</div>

	<c:if test="${not empty result}">
		<script>
				//SWEETALERT
				if("${result}"=="success"){
					Swal.fire({
						icon: 'success',
						title: 'Ottimo!',
						text: "Operazione effettuata con successo!"
						})
				}
				
		</script>
	</c:if>

	<script>
	$(document).ready(function () {

	    var dateSelect = $("#dateSelect");
	    var floorSelect = $("#floorSelect");
	    var roomSelect = $("#roomSelect");

	    var insertedPlanimetry = '${insertedPlanimetry}';

	    var container = $(".flex-container");

	    if(insertedPlanimetry.length > 0){
		    loadRoom(1);
		    console.log(insertedPlanimetry.length);

		    //LOAD FLOORS
		    if (insertedPlanimetry.length > 0) {
		        var arrayJson = JSON.parse(insertedPlanimetry);
		        var arrayFloor = [];
		        for (var i = 0; i < arrayJson.length; i++) {
		            if (!(arrayFloor.includes(arrayJson[i].floor))) {
		                arrayFloor.push(arrayJson[i].floor);
		            }
		        }
		    }
		    floorSelect.html("");
		    for (var j = 0; j < arrayFloor.length; j++) {
		        floorSelect.append("<option value=" + arrayFloor[j] + ">" + arrayFloor[j] + "</option>");
		    }

		    loadPlanimetry();
	    } else {
	    	$("#selectRow").remove();
	    	$("#scrollDiv").remove();
	    	$(".card-header").html("");
	    	$(".card-header").append("<h3 class='my-auto'>Avviso</h3>");
	    	$(".card-body").html("");
            $(".card-body").append("<h2 class='my-auto'>Planimetria non inserita.</h2>");
	    }
	    


	    //LOAD ROOMS
	    function loadRoom(piano) {
	        if (insertedPlanimetry.length > 0) {
	            var arrayJson = JSON.parse(insertedPlanimetry);
	            var arrayRoom = [];
	            for (var i = 0; i < arrayJson.length; i++) {
	                if (arrayJson[i].floor == piano) {
	                    arrayRoom.push(arrayJson[i].room);
	                }
	            }
	        }
	        roomSelect.html("");
	        for (var j = 0; j < arrayRoom.length; j++) {
	            roomSelect.append("<option value=" + arrayRoom[j] + ">" + arrayRoom[j] + "</option>");
	        }
	    }


	    //LOAD PLANIMETRY
	    function loadPlanimetry() {

	        var date = dateSelect.val();
	        var floor = floorSelect.val();
	        var room = roomSelect.val();

	        if (((dateSelect.val() != null) && (floorSelect.val() != null) && (roomSelect.val() != null))) {

	            var xhttp = new XMLHttpRequest();
	            xhttp.onreadystatechange = function () {
	                if (this.readyState == 4 && this.status == 200) {
	                    var lista = JSON.parse(this.responseText);
	                    container.html("");
	                    for (var i = 0; i < lista.length; i++) {
	                        if (lista[i].status == 0) {
	                            container.append("<svg width='50' height='50'> <rect width='50' height='50' style='fill:green;stroke:black;stroke-width:5;opacity:0.5' /> <text x='50%' y='50%' text-anchor='middle' fill='white' font-family='Lato' dy='.4em' font-weight='bold' style='opacity: 0.8;'>" + lista[i].workstation + "</text> </svg>");
	                        } else if (lista[i].status == 1) {
	                            console.log(lista[i]);
	                            container.append("<svg width='50' height='50'> <rect width='50' height='50' style='fill:red;stroke:black;stroke-width:5;opacity:0.5' class='unavailable' /> <text x='50%' y='50%' text-anchor='middle' fill='black' font-family='Lato' dy='.4em' font-weight='bold' style='opacity: 0.6;'>" + lista[i].workstation + "</text> </svg>");
	                        }
	                    }
	                    //ONCLICK 
	                    clickedElement = $(".flex-container > svg");
	                    var clicked = "";

	                    clickedElement.on("click", function () {
	                        clicked = $(this);

	                        if (clicked.children("rect").hasClass("unavailable")) { return; }

	                        //SWEETALERT
	                        Swal.fire({
	                            title: 'Sei sicuro?',
	                            text: "Stai prenotando questa postazione:\nPiano: " + floorSelect.val() + "\nStanza:" + roomSelect.val() + "\nPostazione: " + clicked.children("text").html(),
	                            icon: 'warning',
	                            showCancelButton: true,
	                            confirmButtonColor: '#3085d6',
	                            cancelButtonColor: '#d33',
	                            cancelButtonText: 'Cancella',
	                            confirmButtonText: 'Si, voglio prenotare'
	                        }).then((result) => {
	                            if (result.value) {
	                                $("#finalForm").html("<input type='hidden' name='jsonObject' value=\"{'date':'" + dateSelect.find(":selected").text() + "', 'workstation':" + clicked.children('text').text() + ", 'room':'" + roomSelect.find(":selected").text() + "', 'floor':" + floorSelect.find(":selected").text() + "}\">");
	                                $("#finalForm").submit();
	                            }	
	                            else if (result.dismiss === Swal.DismissReason.cancel) {
	                                Swal.fire(
	                                    'Cancellata!',
	                                    'La prenotazione e\' stata annullata',
	                                    'error'
	                                )
	                            }	
	                        });
	                    });
	                }
	            }
	            xhttp.open("GET", "WorkstationsAvailability?date=" + date + "&floor=" + floor + "&room=" + room, true);
	            xhttp.send();
	        } else {
	            $(".card-header").html("");
	            $(".card-header").append("<h3 class='my-auto'>Avviso</h3>");
	            $(".card-body").html("");
	            $(".card-body").prop("height:250px; display: flex; align-items: center;");
	            $(".card-body").append("<h2 class='my-auto mx-auto'>Hai già prenotato il numero massimo di postazioni.</h2>");
	        }
	    }


	    roomSelect.on("change", function () {
	        loadPlanimetry();
	    });
	    floorSelect.on("change", function () {
	        loadRoom(floorSelect.val());
	        loadPlanimetry();
	    });
	    dateSelect.on("change", function () {
	        loadPlanimetry();
	    });
	});
	</script>

</body>
</html>