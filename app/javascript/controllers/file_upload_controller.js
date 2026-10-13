import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="file-upload"
export default class extends Controller {
    static targets = ["dropContainer", "fileInput", "preview"]

    static values = {
        accept: String,
        multiple: Boolean,
        preview: Boolean
    }

    disconnect() {
        this.clearPreview()
    }

    dragover(event) {
        event.preventDefault()
    }

    dragenter(event) {
        event.preventDefault()

        this.dropContainerTarget.classList.add(
            "border-primary",
            "bg-primary-subtle"
        )
    }

    dragleave(event) {
        if (
            event.relatedTarget &&
            this.dropContainerTarget.contains(event.relatedTarget)
        ) {
            return
        }

        this.deactivateDropzone()
    }

    drop(event) {
        event.preventDefault()
        this.deactivateDropzone()

        const files = this.validFiles(Array.from(event.dataTransfer.files))
        const selectedFiles = this.multipleValue ? files : files.slice(0, 1)

        if (selectedFiles.length === 0) return

        this.setInputFiles(selectedFiles)
        this.fileInputTarget.dispatchEvent(
            new Event("change", { bubbles: true })
        )
    }

    filesChanged() {
        const files = Array.from(this.fileInputTarget.files)

        this.renderPreview(files)
    }

    removeFile(index) {
        const files = Array.from(this.fileInputTarget.files)
            .filter((_, fileIndex) => fileIndex !== index)

        this.setInputFiles(files)
        this.renderPreview(files)
    }

    validFiles(files) {
        if (!this.hasAcceptValue || this.acceptValue.length === 0) {
            return files
        }

        const acceptedTypes = this.acceptValue
            .split(",")
            .map((type) => type.trim().toLowerCase())
            .filter(Boolean)

        return files.filter((file) => {
            return acceptedTypes.some((acceptedType) => {
                return this.fileMatchesType(file, acceptedType)
            })
        })
    }

    fileMatchesType(file, acceptedType) {
        const fileName = file.name.toLowerCase()
        const fileType = file.type.toLowerCase()

        if (acceptedType.startsWith(".")) {
            return fileName.endsWith(acceptedType)
        }

        if (acceptedType.endsWith("/*")) {
            const category = acceptedType.replace("*", "")

            return fileType.startsWith(category)
        }

        return fileType === acceptedType
    }

    setInputFiles(files) {
        const transfer = new DataTransfer()

        files.forEach((file) => transfer.items.add(file))

        this.fileInputTarget.files = transfer.files
    }

    renderPreview(files) {
        this.clearPreview()

        if (!this.previewValue) return

        files.forEach((file, index) => {
            this.previewTarget.appendChild(
                this.buildPreviewItem(file, index)
            )
        })
    }

    buildPreviewItem(file, index) {
        const item = document.createElement("div")

        item.classList.add(
            "border",
            "rounded-3",
            "p-2",
            "d-flex",
            "align-items-center",
            "gap-3"
        )

        item.appendChild(this.buildPreviewMedia(file))
        item.appendChild(this.buildFileDetails(file))
        item.appendChild(this.buildRemoveButton(index))

        return item
    }

    buildPreviewMedia(file) {
        if (file.type.startsWith("image/")) {
            return this.buildImagePreview(file)
        }

        if (file.type.startsWith("video/")) {
            return this.buildVideoPreview(file)
        }

        const filePreview = document.createElement("div")

        filePreview.classList.add(
            "file-upload-preview-media",
            "rounded",
            "bg-body-tertiary",
            "d-flex",
            "align-items-center",
            "justify-content-center"
        )

        filePreview.textContent = "File"

        return filePreview
    }

    buildImagePreview(file) {
        const image = document.createElement("img")
        const objectUrl = URL.createObjectURL(file)

        image.src = objectUrl
        image.alt = file.name
        image.dataset.objectUrl = objectUrl
        image.classList.add(
            "file-upload-preview-media",
            "rounded",
            "object-fit-cover"
        )

        return image
    }

    buildVideoPreview(file) {
        const video = document.createElement("video")
        const objectUrl = URL.createObjectURL(file)

        video.src = objectUrl
        video.dataset.objectUrl = objectUrl
        video.muted = true
        video.preload = "metadata"
        video.classList.add(
            "file-upload-preview-media",
            "rounded",
            "object-fit-cover"
        )

        return video
    }

    buildFileDetails(file) {
        const details = document.createElement("div")
        const name = document.createElement("div")
        const size = document.createElement("div")

        details.classList.add("flex-grow-1", "overflow-hidden")

        name.classList.add("fw-medium", "text-truncate")
        name.textContent = file.name

        size.classList.add("small", "text-body-secondary")
        size.textContent = this.formatFileSize(file.size)

        details.appendChild(name)
        details.appendChild(size)

        return details
    }

    buildRemoveButton(index) {
        const button = document.createElement("button")

        button.type = "button"
        button.classList.add("btn-close", "ms-auto")
        button.setAttribute("aria-label", "Remove file")

        button.addEventListener("click", () => {
            this.removeFile(index)
        })

        return button
    }

    clearPreview() {
        if (!this.hasPreviewTarget) return

        this.previewTarget
            .querySelectorAll("[data-object-url]")
            .forEach((element) => {
                URL.revokeObjectURL(element.dataset.objectUrl)
            })

        this.previewTarget.replaceChildren()
    }

    deactivateDropzone() {
        this.dropContainerTarget.classList.remove(
            "border-primary",
            "bg-primary-subtle"
        )
    }

    formatFileSize(bytes) {
        if (bytes === 0) return "0 B"

        const units = ["B", "KB", "MB", "GB"]
        const unitIndex = Math.floor(Math.log(bytes) / Math.log(1024))
        const size = bytes / (1024 ** unitIndex)

        return `${size.toFixed(1)} ${units[unitIndex]}`
    }
}