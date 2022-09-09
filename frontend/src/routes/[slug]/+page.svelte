<script>
  import tailData from "../../data/tailData.json";
  import { onMount } from "svelte";
  export let data;
  let filteredData;
  let loader = true;

  onMount(async () => {
    getTailData();
  });

  async function getTailData() {
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
        filteredData = tailData.filter(
          (item) => item.id === result.data.long_tails_aggregate.nodes[0].json_id
        );
        loader = false;
      })
      .catch((error) => {
        console.log("error", error);
      });
  }
</script>

<div>
  {#if !loader}
    <div class="centerText">
      <div class="textStyle">
        <h2>Title :</h2>
        &nbsp;
        <h3>{filteredData[0].title}</h3>
      </div>
      <div class="textStyle">
        <h2>Description :</h2>
        &nbsp;
        <h3>{filteredData[0].description}</h3>
      </div>
    </div>
  {/if}
</div>

<style>
  .centerText {
    display: flex;
    height: 225px;
    align-items: center;
    justify-content: center;
  }
  .textStyle {
    display: flex;
    flex-direction: row;
    align-items: center;
    margin: 25px;
  }
</style>
