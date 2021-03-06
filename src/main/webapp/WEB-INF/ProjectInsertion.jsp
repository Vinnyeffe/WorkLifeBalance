<%@ page import="java.util.*,it.unisa.wlb.model.bean.Employee"%>
<!DOCTYPE html>
<html lang="it">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no'
	name='viewport' />

<!-- Title -->
<title>WLB - Inserimento progetto</title>

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
</head>
<body>

	<div class="wrapper">
		<jsp:include page="Header.jsp" />

		<div class="main-panel">

			<!-- CORPO PAGINA-->
			<div class="content" style="display: flex; align-items: center;">

				<!-- CONTAINER -->
				<div class="container mt-4 text-center">

					<!-- COLONNA -->
					<div class="col-lg-9 mx-auto">

						<!-- CARD -->
						<div class="card">
							<div class="card-header">
								<h3 class="my-auto">Inserimento progetto</h3>
							</div>

							<!-- CARD-BODY -->
							<div class="card-body">

								<!-- FORM -->
								<form action="AddProjectServlet" method="post">

									<!-- CONTAINER -->
									<div class="container">

										<!-- NOME -->
										<div class="form-group input-group mx-auto">
											<div class="input-group-prepend">
												<span class="input-group-text"><i class="fa fa-user"></i></span>
											</div>
											<input type="text" class="form-control text-center"
												name="name" id="name" onkeyup="verificaNome()"
												placeholder="Nome..." required>
										</div>
										<span id="errorName"> </span>


										<!-- SCOPE -->
										<div class="form-group input-group mx-auto">
											<div class="input-group-prepend">
												<span class="input-group-text"><i
													class="fas fa-search"></i></span>
											</div>
											<input type="text" class="form-control text-center"
												name="scope" id="scope" onkeyup="verificaScope()"
												placeholder="Scope..." required>
										</div>
										<span id="errorScope"> </span>


										<!-- DATA INIZIO -->
										<div class="form-group input-group mx-auto">
											<div class="input-group-prepend">
												<span class="input-group-text"><i
													class="fas fa-calendar-plus"></i></span>
											</div>
											<input type="date" class="form-control text-center"
												name="startDate" id="startDate"
												onblur="verificaDataInizio()"
												placeholder="Data di inizio: yyyy-MM-dd" required>
										</div>
										<span id="errorDataInizio"> </span>


										<!-- DATA FINE -->
										<div class="form-group input-group mx-auto">
											<div class="input-group-prepend">
												<span class="input-group-text"><i
													class="fas fa-calendar-minus"></i></span>
											</div>
											<input type="date" class="form-control text-center"
												name=endDate id="endDate" onblur="verificaDataFine()"
												placeholder="Data di fine: yyyy-MM-dd" required>
										</div>
										<span id="errorDataFine"> </span>


										<!-- DESCRIZIONE -->
										<div class="form-group input-group mx-auto">
											<div class="input-group-prepend">
												<span class="input-group-text"><i
													class="fas fa-comment-alt"></i></span>
											</div>
											<textarea name="description" id="description"
												class="form-control text-center"
												onblur="verificaDescrizione()" placeholder="Descrizione..."
												required></textarea>
										</div>
										<span id="errorDescrizione"> </span>


										<!-- MANAGER -->
										<div class="form-group input-group mx-auto">
											<div class="input-group-prepend">
												<span class="input-group-text"><i class="fa fa-user"></i></span>
											</div>
											<input type="text" class="form-control text-center"
												name="managerEmail" id="managerEmail"
												onchange="verificaManager()"
												onkeypress="SuggestionsManager(this.value)"
												placeholder="E-mail manager..." required
												list="suggestionsManager">
											<datalist id="suggestionsManager"></datalist>
										</div>
										<span id="errorManager"> </span>


										<!-- LISTA DIPENDENTI -->
										<div class="form-group row pb-1">
											<div class="col-lg-7">
												<div class="card">
													<div class="card-header p-2">
														<h3 class="my-auto">Lista dipendenti:</h3>
													</div>
													<div class="card-body">
														<div class="form-group text-center mx-auto">
															<ul class="list-group list-group-bordered"
																id="employeeList">

															</ul>
														</div>
													</div>
												</div>
											</div>


											<!-- INSERISCI DIPENDENTE (BOTTONE TRIGGER) -->
											<div class="col-lg-5 mx-auto mb-auto">
												<!-- Button trigger modal -->
												<button type="button" class="btn btn-warning mx-auto"
													data-toggle="modal" data-target="#exampleModal">
													Inserisci dipendente <i class="fas fa-plus ml-2 my-auto"></i>
												</button>
											</div>
										</div>

										<hr>

										<div class="col-lg-4 mx-auto">
											<button type="submit" class="btn btn-success"
												id="insertButton" disabled>Inserisci</button>
										</div>

										<!-- FINE CONTAINER -->
									</div>

									<!-- FINE FORM DI INSERIMENTO PROGETTO -->
								</form>

								<!-- Modal -->
								<div class="modal fade" id="exampleModal" tabindex="-1"
									role="dialog" aria-labelledby="exampleModalLabel"
									aria-hidden="true">
									<div class="modal-dialog modal-dialog-centered" role="document">
										<div class="modal-content">
											<div class="modal-header text-center">
												<h5 class="modal-title" id="exampleModalLabel">Inserisci
													dipendente</h5>
												<button type="button" class="close" data-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>

											<div class="modal-body">
												<h3>Ricerca dipendente</h3>

												<div class="input-group mb-3">
													<input type="email"
														onkeyup="SuggestionsEmployee(this.value)"
														class="form-control" placeholder="m.red1@wlb.it"
														aria-describedby="basic-addon1" name="q" id="lista"
														list="suggestionsEmployee">
													<div class="input-group-append">
														<button class="input-group-text" type="button"
															onclick="insertEmployee(lista.value)"
															data-dismiss="modal">
															<i class="fas fa-plus-square"></i>
														</button>
													</div>
												</div>
												<datalist id="suggestionsEmployee"></datalist>
											</div>
										</div>
									</div>
								</div>

								<!-- END CARD BODY -->
							</div>

							<!-- END CARD -->
						</div>

						<!-- END COLONNA -->
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

	<script>
		var nomeOK = false;
		var scopeOK = false;
		var dataInizioOK = false;
		var dataFineOK = false;
		var descrizioneOK = false;
		var managerOK = false;
		var dipendentiOK = false;

		function verificaNome() {

			var errorMsg = "Il nome pu� contenere solo lettere minuscole e maiuscole e deve avere una lunghezza tra 4 e 15 caratteri.";
			var input = $("#name").val();

			if (input.trim().length >= 4 && input.trim().length <= 15
					&& input.match(/^[A-Za-z0-9]+$/)) {

				var xmlHttpReq = new XMLHttpRequest();
				xmlHttpReq.onreadystatechange = function() {
					if (xmlHttpReq.readyState == 4 && xmlHttpReq.status == 200) {
						var json = JSON.parse(xmlHttpReq.responseText);
						if (json != null) {
							if (json.available == "yes") {
								if ($("#name").hasClass("is-invalid"))
									$("#name").removeClass("is-invalid");
								
								$("#name").addClass("is-valid");
								document.getElementById("errorName").innerHTML = "";
								nomeOK = true;
							} else {
								if ($("#name").hasClass("is-valid"))
									$("#name").removeClass("is-valid");
								
								$("#name").addClass("is-invalid");
								document.getElementById("errorName").innerHTML = "Attenzione! Questo nome � gi� associato ad un altro progetto.";
								nomeOK = false;
							}
						}
					}
					changeInsertButtonState();
				}
				xmlHttpReq.open("GET", "CheckProject?name="
						+ encodeURIComponent(input), true);
				xmlHttpReq.send();
			} else {
				if ($("#name").hasClass("is-valid"))
					$("#name").removeClass("is-valid");
				
				$("#name").addClass("is-invalid");
				document.getElementById("errorName").innerHTML = errorMsg;
				nomeOK = false;
				changeInsertButtonState();
			}
		}

		function verificaScope() {

			var errorMsg = "Lo scope deve avere una lunghezza tra 3 e 25 caratteri.";
			var input = $("#scope").val();
			if (input.trim().length >= 3 && input.trim().length <= 25
					&& input.match(/^[A-Za-z\s]+$/)) {
				if ($("#scope").hasClass("is-invalid"))
					$("#scope").removeClass("is-invalid");
				
				$("#scope").addClass("is-valid");
				document.getElementById("errorScope").innerHTML = "";
				scopeOK = true;
			} else {
				if ($("#scope").hasClass("is-valid"))
					$("#scope").removeClass("is-valid");
			
				$("#scope").addClass("is-invalid");
				document.getElementById("errorScope").innerHTML = errorMsg;
				scopeOK = false;
			}
			changeInsertButtonState();
		}

		function verificaDataInizio() {

			var errorMsg = "Formato non corretto!";
			var input = $("#startDate").val();
			if (input
				.match(/^(19|20)\d{2}[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])$/)) {
				var endDate = $("#endDate").val();
				var startDate = input;
				if (endDate != null && endDate.match(/^(19|20)\d{2}[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])$/)) {
					var dateStartDate = new Date(startDate);
					var dateEndDate = new Date(endDate);
					verificaDate(dateStartDate, dateEndDate);
				} else {
					if ($("#startDate").hasClass("is-invalid"))
						$("#startDate").removeClass("is-invalid");
					
					$("#startDate").addClass("is-valid");
					document.getElementById("errorDataInizio").innerHTML = "";
					dataInizioOK = true;
				}
			} else {
				if ($("#startDate").hasClass("is-valid"))
					$("#startDate").removeClass("is-valid");
				
				$("#startDate").addClass("is-invalid");
				document.getElementById("errorDataInizio").innerHTML = errorMsg;
				dataInizioOK = false;
			}
			changeInsertButtonState();
		}

		function verificaDataFine() {

			var errorMsg = "Formato non corretto!";
			var input = $("#endDate").val();
			if (input.match(/^(19|20)\d{2}[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])$/)) {
				var startDate = $("#startDate").val();
				var endDate = input;
				if (startDate != null && startDate.match(/^(19|20)\d{2}[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])$/)) {
					var dateStartDate = new Date(startDate);
					var dateEndDate = new Date(endDate);
					verificaDate(dateStartDate, dateEndDate);
				} else {
					//ENDDATE
					if ($("#endDate").hasClass("is-invalid"))
						$("#endDate").removeClass("is-invalid");
				
					$("#endDate").addClass("is-valid");
					document.getElementById("errorDataFine").innerHTML = "";
					dataFineOK = true;
				}
			} else {
				if ($("#endDate").hasClass("is-valid"))
					$("#endDate").removeClass("is-valid");
				
				$("#endDate").addClass("is-invalid");
				document.getElementById("errorDataFine").innerHTML = errorMsg;
				dataFineOK = false;
			}
			changeInsertButtonState();
		}

		function verificaDate(startDate, endDate) {
		
			if (startDate < endDate) {
				//STARTDATE
				if ($("#startDate").hasClass("is-invalid"))
					$("#startDate").removeClass("is-invalid");
				$("#startDate").addClass("is-valid");
				document.getElementById("errorDataInizio").innerHTML = "";
				dataInizioOK = true;

				//ENDDATE
				if ($("#endDate").hasClass("is-invalid"))
					$("#endDate").removeClass("is-invalid");
				
				$("#endDate").addClass("is-valid");
				document.getElementById("errorDataFine").innerHTML = "";
				dataFineOK = true;
			} else {
				//STARTDATE
				if ($("#startDate").hasClass("is-invalid"))
					$("#startDate").removeClass("is-invalid");
				//AGGIUNGO LA CLASSE 'IS-VALID'
				$("#startDate").addClass("is-valid");
				document.getElementById("errorDataInizio").innerHTML = "";
				dataInizioOK = true;

				//ENDDATE
				if ($("#endDate").hasClass("is-valid"))
					$("#endDate").removeClass("is-valid");
				
				$("#endDate").addClass("is-invalid");
				document.getElementById("errorDataFine").innerHTML = "La data di fine deve seguire quella di inzio!";
				dataFineOK = false;
			}
		}

		function verificaDescrizione() {

			var errorMsg = "La descrizione deve avere una lunghezza minima di 20 caratteri e massima di 250.";
			var input = $("#description").val();

			if (input.trim().length >= 20 && input.trim().length <= 250
					&& input.match(/^[\s\S]+$/)) {
				
				if ($("#description").hasClass("is-invalid"))
					$("#description").removeClass("is-invalid");
			
				$("#description").addClass("is-valid");
				document.getElementById("errorDescrizione").innerHTML = "";
				descrizioneOK = true;
			} else {
				if ($("#description").hasClass("is-valid"))
					$("#description").removeClass("is-valid");
			
				$("#description").addClass("is-invalid");
				document.getElementById("errorDescrizione").innerHTML = errorMsg;
				descrizioneOK = false;
			}
			changeInsertButtonState();
		}

		function verificaManager() {

			var errorMsg = "L'email del manager deve essere del seguente tipo: m.rossi1@wlb.it.";
			var input = $("#managerEmail").val();
			if (input.match(/^[a-z]{1}\.[a-z]+[0-9]+\@wlb.it$/)) {

				var xmlHttpReq = new XMLHttpRequest();
				xmlHttpReq.onreadystatechange = function() {
					if (xmlHttpReq.readyState == 4 && xmlHttpReq.status == 200) {
						var json = JSON.parse(xmlHttpReq.responseText);
						if (json != null) {
							if (json.status == 1) {
								if ($("#managerEmail").hasClass("is-invalid"))
									$("#managerEmail")
											.removeClass("is-invalid");
								
								$("#managerEmail").addClass("is-valid");
								document.getElementById("errorManager").innerHTML = "";
								managerOK = true;
							} else {
								
								if ($("#managerEmail").hasClass("is-valid"))
									$("#managerEmail").removeClass("is-valid");
								
								$("#managerEmail").addClass("is-invalid");
								document.getElementById("errorManager").innerHTML = "L'utente selezionato non � un manager!";
								managerOK = false;
							}
						}
					}
					changeInsertButtonState();
				}
				xmlHttpReq.open("GET", "CheckManager?email="
						+ encodeURIComponent(input), true);
				xmlHttpReq.send();
			} else {
				
				if ($("#managerEmail").hasClass("is-valid"))
					$("#managerEmail").removeClass("is-valid");
				
				$("#managerEmail").addClass("is-invalid");
				document.getElementById("errorManager").innerHTML = errorMsg;
				managerOK = false;
				changeInsertButtonState();
			}
		}

		function changeInsertButtonState() {

			var btn = $("#insertButton");
			if (nomeOK && scopeOK && dataInizioOK && dataFineOK
					&& descrizioneOK && managerOK && dipendentiOK) {
				document.getElementById('insertButton').disabled = false;
				btn.css("background-color", "#31CE36");
				btn.css("color", "#ffffff");
			} else {
				document.getElementById('insertButton').disabled = true;
				btn.css("background-color", "#d6d6d6");
				btn.css("color", "#ffffff");
			}
		}

		function SuggestionsEmployee(email) {

			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {

					var lista = JSON.parse(this.responseText);

					var options = "";

					for (i = 0; i < lista.length; i++) {
						options += "<option>" + lista[i].email + "</option>";
					}
					document.getElementById("suggestionsEmployee").innerHTML = options;
					dipendentiOK = true;
					changeInsertButtonState();
				}
			}
			xhttp.open("GET", "SuggestionEmployees?email=" + email + "&flag=0",
					true);
			xhttp.send();
		}

		function SuggestionsManager(email) {

			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {

					var lista = JSON.parse(this.responseText);

					var options = "";

					for (i = 0; i < lista.length; i++) {
						options += "<option>" + lista[i].email + "</option>";
					}
					document.getElementById("suggestionsManager").innerHTML = options;
				}
			}
			xhttp.open("GET", "SuggestionEmployees?email=" + email + "&flag=1",
					true);
			xhttp.send();
		}

		function insertEmployee(email) {
			var manager = $("#managerEmail").val();
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var lista = JSON.parse(this.responseText);
					var li = "";

					li += "<li class='list-group-item'><i class='fas fa-user my-auto mr-2'></i>"
							+ lista.emailEmployee + "</li>";
					document.getElementById("employeeList").innerHTML += li;

				}
			}
			xhttp.open("GET", "AddEmployeeToList?email=" + email+"&emailManager="+manager, true);
			xhttp.send();
		}
	</script>

</body>
</html>