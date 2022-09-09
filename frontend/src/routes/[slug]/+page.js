export function load({ params }) {
  console.log(params.slug);
  const slug = params.slug;
  return {
    slug,
  };
}
