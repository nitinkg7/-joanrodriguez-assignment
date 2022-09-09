<script>
  import { request, gql } from "graphql-request";
  export let data;

  const query = gql`
    {
      company {
        ceo
      }
      roadster {
        apoapsis_au
      }
    }
  `;

  request("https://api.spacex.land/graphql/", query).then((data) => console.log(data));
</script>

<h1>{data.slug}</h1>
