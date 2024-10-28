CREATE TABLE "admins" (
  "admin_id" SERIAL PRIMARY KEY,
  "username" VARCHAR(50),
  "password" VARCHAR(255),
  "email" VARCHAR(100)
);

CREATE TABLE "students" (
  "student_id" SERIAL PRIMARY KEY,
  "admin_id" INT,
  "class_id" INT,
  "grade" VARCHAR(10)
);

CREATE TABLE "mentors" (
  "mentor_id" SERIAL PRIMARY KEY,
  "admin_id" INT,
  "expertise" VARCHAR(100)
);

CREATE TABLE "classes" (
  "class_id" SERIAL PRIMARY KEY,
  "class_name" VARCHAR(100),
  "mentor_id" INT
);

CREATE TABLE "materials" (
  "material_id" SERIAL PRIMARY KEY,
  "class_id" INT,
  "title" VARCHAR(100),
  "description" TEXT,
  "video_url" VARCHAR(255)
);

CREATE TABLE "schedule" (
  "schedule_id" SERIAL PRIMARY KEY,
  "class_id" INT,
  "date_time" date
);

CREATE TABLE "attendance" (
  "attendance_id" SERIAL PRIMARY KEY,
  "student_id" INT,
  "mentor_id" INT,
  "class_id" INT,
  "date" DATE,
  "status" "ENUM(Hadir,Tidak Hadir)"
);

CREATE TABLE "assignments" (
  "assignment_id" SERIAL PRIMARY KEY,
  "class_id" INT,
  "title" VARCHAR(100),
  "description" TEXT,
  "due_date" DATE
);

CREATE TABLE "grades" (
  "grade_id" SERIAL PRIMARY KEY,
  "student_id" INT,
  "assignment_id" INT,
  "score" DECIMAL(5,2)
);

CREATE TABLE "leaderboard" (
  "leaderboard_id" SERIAL PRIMARY KEY,
  "student_id" INT,
  "score" DECIMAL(5,2),
  "ranking" INT
);

CREATE TABLE "announcements" (
  "announcement_id" SERIAL PRIMARY KEY,
  "title" VARCHAR(100),
  "content" TEXT,
  "created_at" TIMESTAMP,
  "visible_to" ENUM(siswa,mentor,semua)
);

ALTER TABLE "students" ADD FOREIGN KEY ("admin_id") REFERENCES "admins" ("admin_id");

ALTER TABLE "students" ADD FOREIGN KEY ("class_id") REFERENCES "classes" ("class_id");

ALTER TABLE "mentors" ADD FOREIGN KEY ("admin_id") REFERENCES "admins" ("admin_id");

ALTER TABLE "classes" ADD FOREIGN KEY ("mentor_id") REFERENCES "mentors" ("mentor_id");

ALTER TABLE "materials" ADD FOREIGN KEY ("class_id") REFERENCES "classes" ("class_id");

ALTER TABLE "schedule" ADD FOREIGN KEY ("class_id") REFERENCES "classes" ("class_id");

ALTER TABLE "attendance" ADD FOREIGN KEY ("student_id") REFERENCES "students" ("student_id");

ALTER TABLE "attendance" ADD FOREIGN KEY ("mentor_id") REFERENCES "mentors" ("mentor_id");

ALTER TABLE "attendance" ADD FOREIGN KEY ("class_id") REFERENCES "classes" ("class_id");

ALTER TABLE "assignments" ADD FOREIGN KEY ("class_id") REFERENCES "classes" ("class_id");

ALTER TABLE "grades" ADD FOREIGN KEY ("student_id") REFERENCES "students" ("student_id");

ALTER TABLE "grades" ADD FOREIGN KEY ("assignment_id") REFERENCES "assignments" ("assignment_id");

ALTER TABLE "leaderboard" ADD FOREIGN KEY ("student_id") REFERENCES "students" ("student_id");
