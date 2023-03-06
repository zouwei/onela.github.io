import { visit } from "unist-util-visit";
import type * as mdast from "mdast";
import type * as unified from "unified";

export const remarkCodeBlock: unified.Plugin<[], mdast.Root> = () => {
  return (tree) => {
    visit(tree, "code", (node, index, parent) => {
      if (!parent || typeof index !== "number") return;

      const lang = (node.lang ?? "").trim();

      const prev: mdast.Paragraph = {
        type: "paragraph",
        children: [
          {
            type: "html",
            value: `<div class="language-${lang}"><span class="lang">`
          },
          {
            type: "text",
            value: lang
          },
          {
            type: "html",
            value: "</span>"
          }
        ]
      };
      const next: mdast.HTML = {
        type: "html",
        value: "</div>"
      };

      parent.children.splice(index, 0, prev);
      parent.children.splice(index + 2, 0, next);

      return index + 3;
    });
  };
};
