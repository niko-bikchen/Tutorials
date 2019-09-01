<template>
  <nav class="nav nav-pills">
    <ul class="nav nav-pills">
      <!-- Instead of router-link-active it will add active class to the li -->
      <!-- By specifying tag we make li to be the router link (<a></a> is default) -->
      <!-- 
          Default behavior for active style is that it looks where your links to
          and your url and marks element with active when your url begins with to
      -->
      <router-link tag="li" to="/" active-class="active" exact class="nav-link">
        <span style="cursor: pointer;">Home</span>
      </router-link>
      <router-link tag="li" to="/user" active-class="active" class="nav-link">
        <span style="cursor: pointer;">User</span>
      </router-link>
    </ul>
  </nav>
</template>