db = db.getSiblingDB('blog_db');
db.createCollection("posts", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: ["titre", "auteur", "vues"],
         properties: {
            titre: {
               bsonType: "string",
               description: "doit être une chaîne de caractères et est requis"
            },
            auteur: {
               bsonType: "string",
               description: "doit être une chaîne de caractères et est requis"
            },
            vues: {
               bsonType: "int",
               description: "doit être un entier et est requis"
            }
         }
      }
   }
});

db.posts.insertMany([
   { titre: "Docker pour les nuls", auteur: "Admin", vues: NumberInt(150) },
   { titre: "Le NoSQL en 2026", auteur: "ExpertJS", vues: NumberInt(85) },
   { titre: "Sécuriser MongoDB", auteur: "SecuGuru", vues: NumberInt(300) },
   { titre: "Pourquoi le format UBI ?", auteur: "SysAdmin", vues: NumberInt(42) },
   { titre: "Mon premier article", auteur: "Debutant", vues: NumberInt(10) }
]);