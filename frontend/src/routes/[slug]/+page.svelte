<script>
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
          query get_tail_by_type($input: String!) {
            tails(where: {tail_data: {tail: {_eq: $input}}}) {
              type
              details
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
        filteredData = result.data.tails[0].details
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
        <h3>{filteredData.title}</h3>
      </div>
      <div class="textStyle">
        <h2>Description :</h2>
        &nbsp;
        <h3>{filteredData.description}</h3>
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
