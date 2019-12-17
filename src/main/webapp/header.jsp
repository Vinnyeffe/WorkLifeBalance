<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Navbar -->
<div class="main-header">
	<!-- Logo Header -->
	<div class="logo-header" data-background-color="orange">

		<a href="." class="logo"><img src="img/logo.svg"
			alt="navbar brand" class="navbar-brand"></a>
		<button class="navbar-toggler sidenav-toggler ml-auto" type="button"
			data-toggle="collapse" data-target="collapse" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"><i class="icon-menu"></i></span>
		</button>

		<button class="topbar-toggler more">
			<i class="icon-options-vertical"></i>
		</button>
		<div class="nav-toggle">
			<button class="btn btn-toggle toggle-sidebar">
				<i class="icon-menu"></i>
			</button>
		</div>
	</div>
	<!-- End Logo Header -->

	<!-- Navbar Header -->
	<nav class="navbar navbar-header navbar-expand-lg"
		data-background-color="orange">

		<div class="container-fluid">

			<ul class="navbar-nav topbar-nav ml-md-auto align-items-center">
				<li class="nav-item"><h5 class="text-right my-auto mr-3"
						style="color: white;">Login</h5></li>
				<li class="nav-item dropdown hidden-caret"><a
					class="dropdown-toggle profile-pic" data-toggle="dropdown" href="#"
					aria-expanded="false">
						<div class="avatar-sm">
							<img src="img/profile.jpg" alt="..."
								class="avatar-img rounded-circle">
						</div>
				</a>
					<ul class="dropdown-menu dropdown-user animated fadeIn">
						<div class="dropdown-user-scroll scrollbar-outer">
							<li>
								<div class="user-box">
									<div class="avatar-lg">
										<img src=img/profile.jpg " alt="image profile"
											class="avatar-img rounded">
									</div>
									<div class="u-text">
										<h4>Hizrian</h4>
										<p class="text-muted">hello@example.com</p>
										<a href="profile.html" class="btn btn-xs btn-secondary btn-sm">View
											Profile</a>
									</div>
								</div>
							</li>
							<li>
								<div class="dropdown-divider"></div> <a class="dropdown-item"
								href="#">My Profile</a> <a class="dropdown-item" href="#">My
									Balance</a> <a class="dropdown-item" href="#">Inbox</a>
								<div class="dropdown-divider"></div> <a class="dropdown-item"
								href="#">Account Setting</a>
								<div class="dropdown-divider"></div> <a class="dropdown-item"
								href="#">Logout</a>
							</li>
						</div>
					</ul></li>
			</ul>
		</div>
	</nav>
	<!-- End Navbar -->
</div>

<!-- Sidebar -->
<div class="sidebar sidebar-style-2" style="background-color: #2f3640">
	<div class="sidebar-wrapper scrollbar scrollbar-inner">
		<div class="sidebar-content">

			<!-- ADMIN LIST-->
			<ul class="nav nav-primary my-auto">
				<li class="nav-section"><span class="sidebar-mini-icon">
						<i class="fa fa-ellipsis-h"></i>
				</span>
					<h4 class="text-section">Admin</h4></li>
				<li class="nav-item"><a href="#base" class="nav-link"><i
						class="fas fa-layer-group"></i>
						<p class="b">Planimetria</p></a></li>

				<li class="nav-item"><a href="#sidebarLayouts" class="nav-link"><i
						class="fas fa-th-list"></i>
						<p class="b">Dipendente</p></a></li>

				<li class="nav-item"><a href="#forms" class="nav-link"><i
						class="fas fa-pen-square"></i>
						<p class="b">Progetto</p></a></li>
			</ul>

			<!-- DIPENDENTE LIST-->
			<ul class="nav nav-primary my-auto">
				<li class="nav-section"><span class="sidebar-mini-icon">
						<i class="fa fa-ellipsis-h"></i>
				</span>
					<h4 class="text-section">Dipendente</h4></li>
				<li class="nav-item"><a href="#base" class="nav-link"><i
						class="fas fa-layer-group"></i>
						<p class="b">Visualizza planimetria</p></a></li>

				<li class="nav-item"><a href="#sidebarLayouts" class="nav-link"><i
						class="fas fa-th-list"></i>
						<p class="b">Storico</p></a></li>

				<li class="nav-item"><a href="#forms" class="nav-link"><i
						class="fas fa-pen-square"></i>
						<p class="b">Prenota postazione</p></a></li>

				<li class="nav-item"><a href="#forms" class="nav-link"><i
						class="fas fa-pen-square"></i>
						<p class="b">Smart Working</p></a></li>
			</ul>
		</div>
	</div>
</div>