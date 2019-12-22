package it.unisa.wlb.model.bean;

import java.io.Serializable;
import javax.persistence.*;
import javax.validation.constraints.Size;
import org.hibernate.validator.constraints.Length;
import java.util.List;


/**
 * The persistent class for the ADMIN database table.
 * 
 */
@Entity
@Table(name="ADMIN")
@NamedQueries({
	@NamedQuery(name="Admin.findAll", query="SELECT a FROM Admin a"),
	@NamedQuery(name = "Admin.findByEmailPassword", query = "SELECT a FROM Admin a WHERE a.email = :email AND a.password = :password")
})
public class Admin implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="EMAIL", length=37, nullable=false)
	private String email;

	@Column(name="NAME", length=20, nullable=false)
	private String name;

	@Column(name="PASSWORD", length=40, nullable=false)
	private String password;

	@Column(name="SURNAME", length=20, nullable=false)
	private String surname;

	//bi-directional many-to-one association to Floor
	@OneToMany(mappedBy="admin")
	private List<Floor> floors;

	//bi-directional many-to-one association to Project
	@OneToMany(mappedBy="admin")
	private List<Project> projects;

	public Admin() {
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSurname() {
		return this.surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public List<Floor> getFloors() {
		return this.floors;
	}

	public void setFloors(List<Floor> floors) {
		this.floors = floors;
	}

	public Floor addFloor(Floor floor) {
		getFloors().add(floor);
		floor.setAdmin(this);

		return floor;
	}

	public Floor removeFloor(Floor floor) {
		getFloors().remove(floor);
		floor.setAdmin(null);

		return floor;
	}

	public List<Project> getProjects() {
		return this.projects;
	}

	public void setProjects(List<Project> projects) {
		this.projects = projects;
	}

	public Project addProject(Project project) {
		getProjects().add(project);
		project.setAdmin(this);

		return project;
	}

	public Project removeProject(Project project) {
		getProjects().remove(project);
		project.setAdmin(null);

		return project;
	}

}