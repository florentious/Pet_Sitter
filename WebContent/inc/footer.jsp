<%@ page pageEncoding="utf-8" %>

 <%
  String contextPathInFoot = request.getContextPath();
  // contextPathInFoot 넣으면 주기적으로 에러가 남 왜그러는지는 모르겠음
  %>
  
  <!-- footer start -->
  <br><br><br>
  <footer class="bg-dark bd-footer fixed-bottom text-muted" style="color: white; padding: 1em;">
      <div class="container-fluid text-right">
        <p>By OurTeam Since 2019-12-23</p>
      </div>
    </footer>

  <!-- footer end -->

  <!-- Optional JavaScript -->
  <!-- jQuery first, then Popper.js, then Bootstrap JS -->
  <%-- <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
    integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
    crossorigin="anonymous"></script> --%>
 
  <%
  if(contextPathInFoot != null) {
  %>
	<script src="<%=contextPathInFoot %>/js/jquery-3.4.1.js"></script>
  <%
  } else {
  %>
  <script src="/Pet_Sitter/js/jquery-3.4.1.js"></script>
  <%} %>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
    crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
    integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
    crossorigin="anonymous"></script>
</body>

</html>

