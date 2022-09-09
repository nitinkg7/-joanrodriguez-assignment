<script>
  import { request, gql } from "graphql-request";
  import tailData from "../../data/tailData.json";
  import { onMount } from "svelte";
  console.log("taildata", tailData);
  export let data;
  let slugValue = data.slug;
  console.log("data slug", data.slug);
  let filteredData;
  let loader = true;

  onMount(async () => {
    getTailData();
  });

  async function getTailData() {
    console.log("from function");
    await fetch("http://localhost:8080/v1/graphql", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        query: `
          query MyQuery($input: String!) {
            long_tails_aggregate(where: {tail: {_eq: $input}}) {
              nodes {
                json_id
                tail
              }
            }
          }
        `,
        variables: {
          input: data.slug,
        },
      }),
    })
      .then((res) => res.json())
      .then((result) => {
        console.log("tail res::", result, data);
        filteredData = tailData.filter(
          (item) => item.id === result.data.long_tails_aggregate.nodes[0].json_id
        );
        loader = false;
        console.log("final::", filteredData);
      });
  }
</script>

<h1>{data.slug}</h1>
<div>
  {#if !loader}
    <div>
      <h2>{filteredData[0].title}</h2>
      <h2>{filteredData[0].description}</h2>
    </div>
  {/if}
</div>
